class NotesController < ApplicationController
  before_action :set_note, only: [:show, :edit, :update, :destroy]

  # GET /notes
  # GET /notes.json
  def index
    if params[:m]=="1"
      @notes = current_user.notes
      @title = "Mis notas"
      return
    end
    @notes = Note.search(params[:search])
    #raise @notes.inspect.to_yaml
  end

  # GET /notes/1
  # GET /notes/1.json
  def show
    @note.update_visits_count
  end

  # GET /notes/new
  def new
    @note = Note.new
  end

  # GET /notes/1/edit
  def edit
  end

  # POST /notes
  # POST /notes.json
  def create
    @note = current_user.notes.new(note_params)

    respond_to do |format|
      if @note.save
        format.html { redirect_to @note, notice: 'Se creo la nota satisfactoriamente.' }
        format.json { render :show, status: :created, location: @note }
      else
        format.html { render :new }
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /notes/1
  # PATCH/PUT /notes/1.json
  def update
    respond_to do |format|
      if @note.user_id === current_user.id && @note.update(note_params)
        format.html { redirect_to @note, notice: 'Nota actualizada correctamente.' }
        format.json { render :show, status: :ok, location: @note }
      else
        format.html { redirect_to edit_note_path(@note.id), alert: "Usted no puede actualizar la nota." }
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /notes/1
  # DELETE /notes/1.json
  def destroy
    if @note.user_id === current_user.id
      @note.destroy
      @message = "La Nota se elimino con éxito."
    else
      @message = "Error al eliminar, usted no es el dueño de la nota."
    end
    respond_to do |format|
      format.html { redirect_to notes_url, notice: @message }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_note
      @note = Note.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def note_params
      params.require(:note).permit(:title, :body, :category_id, :flag)
    end
end
