defmodule <%= inspect context.web_module %>.ModalComponent do
  use <%= inspect context.web_module %>, :live_component

  @impl true
  def render(assigns) do
    ~L"""
    <div class="modal fade show" id="<%%= @id %>" role="dialog" style="display: block"
      phx-capture-click="close"
      phx-window-keydown="close"
      phx-key="escape"
      phx-target="#<%%= @id %>"
      phx-page-loading>
       <div class="modal-dialog shadow">
         <div class="modal-content">
           <div class="modal-header">
            <h5 class="modal-title"><%%= @title %></h5>
            <%%= live_patch raw("&times;"), to: @return_to, class: "close" %>
          </div>
          <div class="modal-body">
            <%%= live_component @socket, @component, @opts %>
          </div>
        </div>
      </div>
    </div>
    """
  end

  @impl true
  def handle_event("close", _, socket) do
    {:noreply, push_patch(socket, to: socket.assigns.return_to)}
  end
end
