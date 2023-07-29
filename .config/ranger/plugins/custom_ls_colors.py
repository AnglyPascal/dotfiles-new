# Import the class
import ranger.gui.context

# # Add your key names
# ranger.gui.context.CONTEXT_KEYS.append('docs')

# # Set it to False (the default value)
# ranger.gui.context.Context.docs = False

# Or use an array for multiple names
my_keys = ['docs', 'epubs', 'latex']
ranger.gui.context.CONTEXT_KEYS.append(my_keys)

# Set them to False
for key in my_keys:
    code = 'ranger.gui.context.Context.' + key + ' = False'
    exec(code)

import ranger.gui.widgets.browsercolumn

OLD_HOOK_BEFORE_DRAWING = ranger.gui.widgets.browsercolumn.hook_before_drawing

def new_hook_before_drawing(fsobject, color_list):
    if fsobject.basename.endswith(('.pdf', '.djvu')):
        color_list.append('docs')
    elif fsobject.basename.endswith(('.epub', '.cbz', '.cbr')):
        color_list.append('epubs')
    elif fsobject.basename.endswith(('.tex', '.sty')):
        color_list.append('latex')



    return OLD_HOOK_BEFORE_DRAWING(fsobject, color_list)

ranger.gui.widgets.browsercolumn.hook_before_drawing = new_hook_before_drawing
