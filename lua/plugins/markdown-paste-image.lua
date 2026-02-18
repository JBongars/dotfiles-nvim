local function create_image_tag(filepath)
  local link = string.format('![](%s)', filepath)
  vim.api.nvim_put({ link }, 'c', true, true)
end

local function get_paste_cmd()
  local wayland_display = vim.fn.getenv 'WAYLAND_DISPLAY'
  local has_wl_paste = vim.fn.executable 'wl-paste' == 1

  if wayland_display ~= vim.NIL and wayland_display ~= '' and has_wl_paste then
    return 'wl-paste'
  end
  return 'xclip -selection clipboard -o'
end

local function get_clipboard_contents()
  return vim.fn.system(get_paste_cmd()):gsub('%s+$', '')
end

local function save_clipboard_contents_to_filepath(filepath)
  local cmd = string.format('%s > %s', get_paste_cmd(), vim.fn.shellescape(filepath))
  vim.fn.system(cmd)
end

local function is_image_url(str)
  return str:match '^https?://.+%.png[?#]?' ~= nil
    or str:match '^https?://.+%.jpe?g[?#]?' ~= nil
    or str:match '^https?://.+%.gif[?#]?' ~= nil
    or str:match '^https?://.+%.webp[?#]?' ~= nil
end

local function download_image(url, filepath)
  local cmd = string.format('curl -sL %s -o %s', vim.fn.shellescape(url), vim.fn.shellescape(filepath))
  vim.fn.system(cmd)
  return vim.fn.getfsize(filepath) > 0
end

local function is_image_file(filepath)
  local file_type = vim.fn.system('file -b --mime-type ' .. vim.fn.shellescape(filepath)):gsub('%s+', '')
  return file_type:match '^image/' ~= nil, file_type
end

return {
  dir = '.',
  name = 'paste-image',
  ft = 'markdown',
  config = function()
    vim.api.nvim_create_user_command('PasteImage', function()
      local media_dir = '.media'
      vim.fn.mkdir(media_dir, 'p')
      local filename = os.date '%Y%m%d%H%M%S' .. '.png'
      local filepath = media_dir .. '/' .. filename

      local clipboard_contents = get_clipboard_contents()

      -- handle image url
      if is_image_url(clipboard_contents) then
        if download_image(clipboard_contents, filepath) then
          create_image_tag(filepath)
        else
          vim.notify('Failed to download image from URL', vim.log.levels.ERROR)
        end
        return
      end

      -- handle image buffer
      save_clipboard_contents_to_filepath(filepath)

      if vim.fn.getfsize(filepath) <= 0 then
        vim.notify('Failed to paste image - clipboard is empty', vim.log.levels.ERROR)
        return
      end

      local is_image, file_type = is_image_file(filepath)
      if is_image then
        create_image_tag(filepath)
      else
        vim.fn.delete(filepath)
        vim.notify('Clipboard does not contain an image (found: ' .. file_type .. ')', vim.log.levels.ERROR)
      end
    end, {})
  end,
}
