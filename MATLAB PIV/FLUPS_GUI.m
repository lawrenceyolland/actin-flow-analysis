function varargout = FLUPS_GUI(varargin)
%FLUPS_GUI M-file for FLUPS_GUI.fig
%      FLUPS_GUI, by itself, creates a new FLUPS_GUI or raises the existing
%      singleton
%
%      H = FLUPS_GUI returns the handle to a new FLUPS_GUI or the handle to
%      the existing singleton*.
%
%      FLUPS_GUI('Property','Value',...) creates a new FLUPS_GUI using the
%      given property value pairs. Unrecognized properties are passed via
%      varargin to FLUPS_GUI_OpeningFcn.  This calling syntax produces a
%      warning when there is an existing singleton*.
%
%      FLUPS_GUI('CALLBACK') and FLUPS_GUI('CALLBACK',hObject,...) call the
%      local function named CALLBACK in FLUPS_GUI.M with the given input
%      arguments.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help FLUPS_GUI

% Last Modified by GUIDE v2.5 27-Jan-2016 21:32:19

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @FLUPS_GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @FLUPS_GUI_OutputFcn, ...
                   'gui_LayoutFcn',  [], ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
   gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before FLUPS_GUI is made visible.
function FLUPS_GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   unrecognized PropertyName/PropertyValue pairs from the
%            command line (see VARARGIN)

% Choose default command line output for FLUPS_GUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes FLUPS_GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = FLUPS_GUI_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
% varargout{1} = handles.output;


% --- Executes when pivGuiFig is resized.
function pivGuiFig_SizeChangedFcn(hObject, eventdata, handles)
% hObject    handle to pivGuiFig (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes on slider movement.
function img_slider_Callback(hObject, eventdata, handles)
% hObject    handle to img_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

i = round(get(handles.img_slider, 'Value'));

if i <= 0
    i = 1;
end
set(handles.img_no_display, 'String', ['Image: ', num2str(i)]);

handles.im1 = imread(fullfile(handles.path2tif, handles.mov_file), i);
try
    handles.im1 = handles.im1(:,:, get(handles.im_channel_, 'Value'));
catch
end
handles.im1 = double(handles.im1) / 255;

handles.im2 = imread(fullfile(handles.path2tif, handles.mov_file), i+1);
try
    handles.im2 = handles.im2(:,:, get(handles.im_channel_, 'Value'));
catch
end
handles.im2 = double(handles.im2) / 255;

handles = detect_edge(hObject, eventdata, handles);
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function img_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to img_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in filterParamInput.
function filterParamInput_Callback(hObject, eventdata, handles)
% hObject    handle to filterParamInput (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


function umpix__Callback(hObject, eventdata, handles)
% hObject    handle to umpix_ (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of umpix_ as text
%        str2double(get(hObject,'String')) returns contents of umpix_ as a double

% Get microns per pixels ratio.
handles.umpix = str2double(get(hObject, 'String'));
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function umpix__CreateFcn(hObject, eventdata, handles)
% hObject    handle to umpix_ (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function rec_speed__Callback(hObject, eventdata, handles)
% hObject    handle to rec_speed_ (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of rec_speed_ as text
%        str2double(get(hObject,'String')) returns contents of rec_speed_ as a double

% Get frames per second.
handles.fps = 1/str2double(get(hObject, 'String'));
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function rec_speed__CreateFcn(hObject, eventdata, handles)
% hObject    handle to rec_speed_ (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function erosion_size__Callback(hObject, eventdata, handles)
% hObject    handle to erosion_size_ (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of erosion_size_ as text
%        str2double(get(hObject,'String')) returns contents of erosion_size_ as a double

% Get erosion size.
handles.erosion_size = str2double(get(hObject, 'String'));
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function erosion_size__CreateFcn(hObject, eventdata, handles)
% hObject    handle to erosion_size_ (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function dilation_size__Callback(hObject, eventdata, handles)
% hObject    handle to dilation_size_ (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of dilation_size_ as text
%        str2double(get(hObject,'String')) returns contents of dilation_size_ as a double

% Get dilation size
handles.dilation_size = str2double(get(hObject, 'String'));
guidata(hObject, handles);



% --- Executes during object creation, after setting all properties.
function dilation_size__CreateFcn(hObject, eventdata, handles)
% hObject    handle to dilation_size_ (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function small_part__Callback(hObject, eventdata, handles)
% hObject    handle to small_part_ (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of small_part_ as text
%        str2double(get(hObject,'String')) returns contents of small_part_ as a double

% Get size of small particles to remove.
handles.small_part = str2double(get(hObject, 'String'));
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function small_part__CreateFcn(hObject, eventdata, handles)
% hObject    handle to small_part_ (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in edge_alg_.
function edge_alg__Callback(hObject, eventdata, handles)
% hObject    handle to edge_alg_ (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns edge_alg_ contents as cell array
%        contents{get(hObject,'Value')} returns selected item from edge_alg_

% Get edge algorithm.
contents = cellstr(get(hObject, 'String'));
handles.edge_alg = contents{get(hObject, 'Value')};

guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function edge_alg__CreateFcn(hObject, eventdata, handles)
% hObject    handle to edge_alg_ (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function source_size__Callback(hObject, eventdata, handles)
% hObject    handle to source_size_ (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of source_size_ as text
%        str2double(get(hObject,'String')) returns contents of source_size_ as a double

% Get source size
handles.source_size = str2double(get(hObject, 'String'));
guidata(hObject, handles);



% --- Executes during object creation, after setting all properties.
function source_size__CreateFcn(hObject, eventdata, handles)
% hObject    handle to source_size_ (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function search_size__Callback(hObject, eventdata, handles)
% hObject    handle to search_size_ (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of search_size_ as text
%        str2double(get(hObject,'String')) returns contents of search_size_ as a double

% Get search size.
handles.search_size = str2double(get(hObject, 'String'));
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function search_size__CreateFcn(hObject, eventdata, handles)
% hObject    handle to search_size_ (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function grid_distance__Callback(hObject, eventdata, handles)
% hObject    handle to grid_distance_ (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of grid_distance_ as text
%        str2double(get(hObject,'String')) returns contents of grid_distance_ as a double

% Get grid distance.
handles.grid_distance = str2double(get(hObject, 'String'));
guidata(hObject, handles);



% --- Executes during object creation, after setting all properties.
function grid_distance__CreateFcn(hObject, eventdata, handles)
% hObject    handle to grid_distance_ (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function cc_thresh__Callback(hObject, eventdata, handles)
% hObject    handle to cc_thresh_ (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of cc_thresh_ as text
%        str2double(get(hObject,'String')) returns contents of cc_thresh_ as a double

% Get correlation threshold
handles.cc_thresh = str2double(get(hObject, 'String'));
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function cc_thresh__CreateFcn(hObject, eventdata, handles)
% hObject    handle to cc_thresh_ (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes when pivGuiFig is resized.
function pivGuiFig_ResizeFcn(hObject, eventdata, handles)
% hObject    handle to pivGuiFig (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get initial position of all figures, buttons, etc. than need to be
% resized

guidata(hObject,handles);


% --- Executes on selection change in im_channel_.
function im_channel__Callback(hObject, eventdata, handles)
% hObject    handle to im_channel_ (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns im_channel_ contents as cell array
%        contents{get(hObject,'Value')} returns selected item from im_channel_

% Get image im_channel_ used for analysis
handles.im_channel = str2double(get(hObject, 'Value'));
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function im_channel__CreateFcn(hObject, eventdata, handles)
% hObject    handle to im_channel_ (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in is_interpolate_.
function is_interpolate__Callback(hObject, eventdata, handles)
% hObject    handle to is_interpolate_ (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of is_interpolate_

% Check if user wants interpolation.
handles.is_interpolate = get(hObject, 'Value');
guidata(hObject, handles);


function gaussian_kernel__Callback(hObject, eventdata, handles)
% hObject    handle to gaussian_kernel_ (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of gaussian_kernel_ as text
%        str2double(get(hObject,'String')) returns contents of gaussian_kernel_ as a double

% Get Gaussian kernel size.
handles.gaussian_kernel = str2double(get(hObject, 'String'));
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function gaussian_kernel__CreateFcn(hObject, eventdata, handles)
% hObject    handle to gaussian_kernel_ (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function temp_kernel__Callback(hObject, eventdata, handles)
% hObject    handle to temp_kernel_ (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of temp_kernel_ as text
%        str2double(get(hObject,'String')) returns contents of temp_kernel_ as a double

% Get temporal kernel size
handles.temp_kernel = str2double(get(hObject, 'String'));
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function temp_kernel__CreateFcn(hObject, eventdata, handles)
% hObject    handle to temp_kernel_ (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function max_flow_vel__Callback(hObject, eventdata, handles)
% hObject    handle to max_flow_vel_ (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of max_flow_vel_ as text
%        str2double(get(hObject,'String')) returns contents of max_flow_vel_ as a double

% Get maximum flow velocity (used for display).
handles.max_flow_vel = str2double(get(hObject, 'String'));
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function max_flow_vel__CreateFcn(hObject, eventdata, handles)
% hObject    handle to max_flow_vel_ (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function sigma_kernel__Callback(hObject, eventdata, handles)
% hObject    handle to sigma_kernel_ (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of sigma_kernel_ as text
%        str2double(get(hObject,'String')) returns contents of sigma_kernel_ as a double

% Get stardard deviation of spatial kernel.
handles.sigma_kernel = str2double(get(hObject, 'String'));
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function sigma_kernel__CreateFcn(hObject, eventdata, handles)
% hObject    handle to sigma_kernel_ (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function temp_sigma__Callback(hObject, eventdata, handles)
% hObject    handle to temp_sigma_ (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of temp_sigma_ as text
%        str2double(get(hObject,'String')) returns contents of temp_sigma_ as a double

% Get temporal kernel standard deviation.
handles.temp_sigma = str2double(get(hObject, 'String'));
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function temp_sigma__CreateFcn(hObject, eventdata, handles)
% hObject    handle to temp_sigma_ (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function arrow_spacing__Callback(hObject, eventdata, handles)
% hObject    handle to arrow_spacing_ (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of arrow_spacing_ as text
%        str2double(get(hObject,'String')) returns contents of arrow_spacing_ as a double

% Get arrow spacing (used for display).
handles.arrow_spacing = str2double(get(hObject, 'String'));
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function arrow_spacing__CreateFcn(hObject, eventdata, handles)
% hObject    handle to arrow_spacing_ (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes on button press in load_movie.
function load_movie_Callback(hObject, eventdata, handles)
% hObject    handle to load_movie (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Ask user to specify if analysis is done on moving or stationary data.
movie_type = questdlg('Are you analysing a stationary cell movie?', ...
    'Analysis type', ...
    'Yes', 'No', 'No');

if strcmp(movie_type, 'Yes')
    handles.token = 's';
else
    handles.token = 'm';
end

% Get location of .tif file with time lapse movie.
[handles.mov_file, handles.path2tif] = uigetfile('.tif');

% Load first image.
handles.im1 = imread(fullfile(handles.path2tif, handles.mov_file), 1);

try
    handles.im1 = handles.im1(:,:, get(handles.im_channel_, 'Value'));
catch
end
handles.im1 = double(handles.im1) / 255;

% Display first image in main axes. 
axes(handles.main_fig)
imshow(handles.im1);

% Get movie length (# of frames).
handles.nt = length(imfinfo(fullfile(handles.path2tif, handles.mov_file)));

% Set maximum value for slider to number of frames. 
set(handles.img_slider, 'Max', handles.nt-1);
slider_step(1) = 1/(handles.nt-1);
slider_step(2) = 1/(handles.nt-1);
set(handles.img_slider, 'sliderstep', slider_step);

% Store newly created data.
guidata(hObject, handles);



% --- Executes on button press in correlate_frame.
function correlate_frame_Callback(hObject, eventdata, handles)
% hObject    handle to correlate_frame (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles = correlate_im(hObject, eventdata, handles);
guidata(hObject, handles);



% --- Executes on button press in run.
function run_Callback(hObject, eventdata, handles)
% hObject    handle to run (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Create time stamp for current run. Automatically append file names
% with the time and date of the run in the format: HH_MM_DD_MM_YY.
crt_date = clock;
handles.running_tag = [num2str(crt_date(4)), '_', num2str(crt_date(5)), '_', ...
    num2str(crt_date(3)), '_', num2str(crt_date(2)), '_', ...
    num2str(crt_date(1))];

% Clear main axes
cla(handles.main_fig, 'reset');

% Process all frames
for i = 1:handles.nt-1
    % Advance slider
    set(handles.img_slider, 'Value', i);
    set(handles.img_no_display, 'String', ['Image: ', num2str(i)]);
    
    % Load current frame
    handles.im1 = imread(fullfile(handles.path2tif, handles.mov_file), i);
    try
        handles.im1 = handles.im1(:, :, get(handles.im_channel_, 'Value'));
    catch
    end
    handles.im1 = double(handles.im1)/255;
    
    % Load next frame
    handles.im2 = imread(fullfile(handles.path2tif, handles.mov_file), i+1);    
    try
        handles.im2 = handles.im2(:, :, get(handles.im_channel_, 'Value'));
    catch
    end
    
    % Set image counter
    handles.currImgNo = i;
    
    % Update hObject
    guidata(hObject, handles);
    
    % Detect edge in images
    handles = detect_edge(hObject, eventdata, handles);
    
    % Correlate frame
    handles = correlate_im(hObject, eventdata, handles);
    
    % Update structure with raw flow vector for current frame.
    vraw(i).x = handles.x_pos;
    vraw(i).y = handles.y_pos;
    vraw(i).vx = handles.x_vec;
    vraw(i).vy = handles.y_vec;
    vraw(i).cc = handles.c_val;
    % Update hObject
    guidata(hObject, handles);
    
    % Save image + flow field data to flow_struct
    save_actual_im(hObject, eventdata, handles);
end

% Save raw vectors to .mat file.
save(fullfile(handles.path2tif, 'data', ...
    ['piv_field_raw_', handles.token, '_', handles.running_tag, '.mat']), ...
    'vraw');

% Check if the user wants to interpolate, and if so we will run it.
if get(handles.is_interpolate_, 'Value') == 1
    interpolate_flow_nested(handles)
    msgbox('Click OK to continue.', 'PIV with interpolation finished');
else
    msgbox('Click OK to continue.', 'PIV finished');
end


% --- Executes on button press in quit.
function quit_Callback(hObject, eventdata, handles)
% hObject    handle to quit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

answer = questdlg('Are you sure you want to quit?', 'Good Bye!',...
    'Yes', 'No', 'Yes');
if strcmp(answer, 'Yes')
    close gcf
end


% --- Executes on button press in reset.
function reset_Callback(hObject, eventdata, handles)
% hObject    handle to reset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

answer = questdlg('Are you sure you want to clear all data?', ... 
    'Start again', 'Yes', 'No', 'Yes');
if strcmp(answer, 'Yes')
    clear handles
    cla(handles.main_fig, 'reset'); 
end


% --- Executes on button press in detect_edge.
function detect_edge_Callback(hObject, eventdata, handles)
% hObject    handle to detect_edge (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Detect edge
handles = detect_edge(hObject, eventdata, handles);
guidata(hObject, handles);

% ~~~~~~ USER DEFINED FUNCTIONS ~~~~~~
% --- Executes on slider movement.
function handles = detect_edge(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

k = round(get(handles.img_slider, 'Value'));
if k <= 0
    k = 1;
end

axes(handles.main_fig);
im = handles.im1;
imshow(im);
guidata(hObject, handles);

e_meth_l = get(handles.edge_alg_, 'String');
e_meth_v = get(handles.edge_alg_, 'Value');
e_meth = e_meth_l{e_meth_v};

BW1 = edge(im, e_meth);

[L,~] = bwlabel(BW1);
stats = regionprops(L,'Area');
allArea = [stats.Area];

%now_we remove small particles
BW2 = BW1;
li = find(allArea < str2double(get(handles.small_part_, 'String')));
for i = 1:length(li)
    BW2(L == li(i)) = 0;
end

BW2 = imdilate(BW2, ...
    strel('disk', str2double(get(handles.dilation_size_, 'String'))));
BW2f = imfill(BW2, 4, 'holes');
BW2 = imerode(BW2f, ...
    strel('disk', str2double(get(handles.erosion_size_, 'String'))));

BW2_i = edge(double(BW2));
bw2_rc = BW2_i;
BW2_i = -1 * BW2_i + 1;
im_e = double(im) .* double(BW2_i);

bw_c(:,:,1) = single(bw2_rc);
bw_c(:,:,2) = 0;
bw_c(:,:,3) = 0;
[im_ind, map] = gray2ind(im, 256);
im_rgb = ind2rgb(im_ind, map);
im_rgb = im_rgb + bw_c;

axes(handles.main_fig);
imshow(im_rgb);

handles.BW2 = BW2;
handles.im_e = im_e;
handles.im_e_rgb = im_rgb;

guidata(hObject, handles);


% Save image function
function save_actual_im(hObject, eventdata, handles)

% Get current frame.
k = round(get(handles.img_slider, 'value'));
if k <= 0
    k = 1;
end

% First arrange the structure
% flow_struct.d_path = handles.path2tif;
% flow_struct.currImgNo = k;
% flow_struct.im = handles.im1;
% flow_struct.x_pos = handles.x_pos;
% flow_struct.y_pos = handles.y_pos;
% flow_struct.x_vec = handles.x_vec;
% flow_struct.y_vec = handles.y_vec;
% flow_struct.c_val = handles.c_val;
% flow_struct.edge_im = handles.BW2;

% Save PIV parameters to a .mat file
if (k == 1)
    if ~exist(fullfile(handles.path2tif, 'params'), 'dir')
        mkdir(fullfile(handles.path2tif, 'params'), 'dir');
    end
    
    edge_meth = get(handles.edge_alg_, 'String');
    piv_param.edge_method = edge_meth{get(handles.edge_alg_, 'Value')};
    piv_param.small_part_size = str2double(get(handles.small_part_, 'String'));
    piv_param.dilation_size = str2double(get(handles.dilation_size_, 'string'));
    piv_param.erosion_size = str2double(get(handles.erosion_size_, 'String'));
    piv_param.grid_distance = str2double(get(handles.grid_distance_, 'String'));
    piv_param.source_size = str2double(get(handles.source_size_, 'String'));
    piv_param.search_size = str2double(get(handles.search_size_, 'String'));
    piv_param.cc_thresh = str2double(get(handles.cc_thresh_, 'String'));
    
    if handles.is_interpolate_ == 1
        piv_param.interpolation = 'Yes';
        piv_param.gaussian_kernel = ...
            str2double(get(handles.gaussian_kernel_, 'String')); 
        piv_param.temp_kernel = ...
            str2double(get(handles.temp_kernel_, 'String')); 
        piv_param.sigma_kernel = ...
            str2double(get(handles.sigma_kernel_, 'String')); 
        piv_param.temp_sigma = ...
            str2double(get(handles.temp_sigma_, 'String'));
        piv_param.arrow_spacing = ...
            str2double(get(handles.arrow_spacing_, 'String')); 
        piv_param.max_flow_speed = ...
            str2double(get(handles.max_flow_vel_, 'String'));
    else
        piv_param.interpolation = 'No';
    end
    
    save(fullfile(handles.path2tif, 'params', ...
        ['piv_param_', handles.token, '_', handles.running_tag, '.mat']), ...
        'piv_param');
end

if ~exist(fullfile(handles.path2tif, 'data'))
    mkdir(fullfile(handles.path2tif, 'data'))
end

if ~exist(fullfile(handles.path2tif, 'images'))
    mkdir(fullfile(handles.path2tif, 'images'));
end

% save(fullfile(handles.path2tif, 'piv', 'data', 'raw', ...
%     ['frame_', num2str(1000 + num_crt_img), '.mat']), 'flow_struct');

% Display unfiltered retrograde flow vectors.
axes(handles.main_fig);
imshow(handles.im_e_rgb);
hold on
quiver(handles.x_pos, handles.y_pos, handles.x_vec, handles.y_vec,'g');
hold off

% Save image to file
f = figure('visible', 'off');
imshow(handles.im_e_rgb);
hold on
quiver(handles.x_pos, handles.y_pos, handles.x_vec, handles.y_vec,'g');
drawnow;
hold off

im_flow = getframe(f);
im_flow = im_flow.cdata;

% Eliminate gray background introduced by Matlab getframe().
dx = ceil(abs(size(im_flow, 2) - size(handles.im_e_rgb, 2)) / 2);
dy = ceil(abs(size(im_flow, 1) - size(handles.im_e_rgb, 1)) / 2);
% im_flow_resized = im_flow(dy:dy + size(handles.im_e_rgb, 1)-1, ...
%     dx:dx + size(handles.im_e_rgb,2)-1, :);

% Append .tif file with new image.
imwrite(im_flow, fullfile(handles.path2tif, 'images', ...
    ['flow_vectors_', handles.token, '_', handles.running_tag, '.tif']), ...
    'writemode', 'append');

% % Correct Matlab automatic resizing of the image
% im_corr = imread(out);
% im_bw = mean(im_corr,3);
% x_mean = mean(im_bw,2);
% y_mean = mean(im_bw,1);
% x_im_f = find(~(x_mean==255));
% y_im_f = find(~(y_mean==255));
% im_corr_cut = im_corr(x_im_f(1):x_im_f(length(x_im_f)), y_im_f(1):y_im_f(length(y_im_f)), :);
% [y_im_corr_cut, x_im_corr_cut, depth] = size(im_corr_cut);
% im_corr_resized = imresize(im_corr_cut,size(im));
% imwrite(im_corr_resized, out);

close(f)

function handles = correlate_im(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

gd = round(str2double(get(handles.grid_distance_, 'String'))); 
gs = round(str2double(get(handles.source_size_, 'String')));
ss = round(str2double(get(handles.search_size_, 'String')));
c_th = str2double(get(handles.cc_thresh_, 'String'));

k = round(get(handles.img_slider, 'Value'));
if k <= 0
    k = 1;
end

% Find current image outline
% Load current image.
im1 = imread(fullfile(handles.path2tif, handles.mov_file), k);
try
    im1 = im1(:, :, get(handles.im_channel_, 'Value'));
catch
end
im1 = double(im1) / 255; % transform image to double

edge_alg = get(handles.edge_alg_, 'String');
BW1 = edge(im1, edge_alg{get(handles.edge_alg_, 'Value')});
[L,~] = bwlabel(BW1);

stats = regionprops(L, 'Area');
allArea = [stats.Area];

% Remove small particles
BW2 = BW1;
li = find(allArea < str2double(get(handles.small_part_, 'String')));
for i = 1:length(li)
    BW2(L == li(i)) = 0;
end

BW2 = imdilate(BW2, ...
    strel('disk', round(str2double(get(handles.dilation_size_, 'String')))));
BW2f = imfill(BW2, 4, 'holes');
BW2 = imerode(BW2f, ...
    strel('disk', round(str2double(get(handles.dilation_size_, 'String')))));
 
bw_c(:,:,1) = single(edge(double(BW2), 'Canny'));
bw_c(:,:,2) = 0;
bw_c(:,:,3) = 0;
[im_ind, map] = gray2ind(im1, 256);
im_rgb = ind2rgb(im_ind, map);
im_rgb = im_rgb + bw_c;

axes(handles.main_fig);
imshow(im_rgb);
hold on

% Load next frame
im2 = imread(fullfile(handles.path2tif, handles.mov_file), k + 1);
try
    im2 = im2(:, :, round(str2double(get(handles.im_channel_, 'String'))));
catch
end
im2 = double(im2) / 255;

BW2 = imerode(BW2, ...
    strel('disk', round(str2double(get(handles.search_size_, 'String')))));

n = 1;
for i = 1:gd:size(im1, 1)
    for j = 1:gd:size(im1, 2)
        if BW2(i,j) == 1
            try
                sub_roi = im1(i-gs:i+gs, j-gs:j+gs);
            catch
                continue
            end
            try
                sub_area = im2(i-ss:i+ss, j-ss:j+ss);
            catch
                continue
            end
            try
                c = normxcorr2(sub_roi, sub_area);
            catch
                continue
            end
            [xroi, yroi] = size(sub_roi);
            [xarea, yarea] = size(sub_area);
            c = c(xroi:xarea, yroi:yarea);
            [max_c, imax] = max(c(:));
            [ypeak, xpeak] = ind2sub(size(c), imax(1));
            [xc, yc] = size(c);
            x_vector(i,j) = xpeak - (xc + 1) / 2;
            y_vector(i,j) = ypeak - (yc + 1) / 2;
            corr_val(i,j) = max_c;
            n = n + 1;
            
            if max_c >= c_th
                x_p(n) = j;
                y_p(n) = i;
                x_v(n) = xpeak - (xc + 1) / 2;
                y_v(n) = ypeak - (yc + 1) / 2;
                c_val(n) = max_c;
            end
        end
    end
end


quiver(x_p, y_p, x_v, y_v,'g');
hold off

handles.x_pos = x_p;
handles.y_pos = y_p;
handles.x_vec = x_v;
handles.y_vec = y_v;
handles.c_val = c_val;

guidata(hObject, handles);



%In this function we will start to do the interpolation
function interpolate_flow_nested(handles)
%Here we will load the retrograde flow data, and then interpolate it
%according to the spatial and temporal kernel size. The result will be
%stored in a subfolder. There will be a filtering: If the direction of a
%flow changes apruptly in time of space, it will be ignored.

mue2pix_ratio = str2double(get(handles.umpix_, 'String'));
fps = 1 / str2double(get(handles.rec_speed_, 'String')); 
xcorr_thresh = str2double(get(handles.cc_thresh_, 'String'));
k_size = 2 * (ceil(0.5 * str2double(get(handles.gaussian_kernel_, 'String')) / ...
    mue2pix_ratio));
k_sigma = 2 *(ceil(0.5 * str2double(get(handles.sigma_kernel_, 'String')) / ...
    mue2pix_ratio));
k_size_temp = str2double(get(handles.temp_kernel_, 'String')); 
k_sigma_temp = str2double(get(handles.temp_sigma_, 'String'));
max_flow_vel = str2double(get(handles.max_flow_vel_, 'String'));
flow_field_arrow_distance = str2double(get(handles.arrow_spacing_, 'String')); 

% Load raw flow data.
flow = load(fullfile(handles.path2tif, 'data', ...
    ['piv_field_raw_', handles.token, '_', handles.running_tag, '.mat']));
for i = 1:length(flow.vraw)
    % We directly switch from pixel per image to the mue/min
    list(:, 1) = flow.vraw(i).x;
    list(:, 2) = flow.vraw(i).y;
    list(:, 3) = flow.vraw(i).vx * mue2pix_ratio * fps * 60;
    list(:, 4) = flow.vraw(i).vy * mue2pix_ratio * fps * 60;
    list(:, 5) = flow.vraw(i).cc;
    list_cell{i} = list;
    clear list
end

% Get the max and min x and y values of the flow vectors startpoints for 
% the full image series (means you get the values closest to the image 
% boarder in all the time series).
t = max(size(list_cell));
for j = 1:t
    list = list_cell{j};
    y(j) = max(list(:, 2));
    x(j) = max(list(:, 1));
    y_min(j) = min(list(:, 2));
    x_min(j) = min(list(:, 1));
end

% To prevent problems with flow values too close to the upper or left image 
% boarder (so that the filter kernel would reach outside the image and 
% negative array indices are not defined, in the positive direction there 
% is no problem, the code just fills up the missing values with zeros),
% check if the min x,y values of the flow points in list_cell are within 
% kernel/2. If not, shift the startpoints of the flow arrows, and all the 
% images in the series. All the shift info is stored in the x_shift, and 
% y_shift variables.
if (min(x_min) <= k_size/2)
    x_shift = ceil(k_size/2 - min(x_min) + 1); 
else
    x_shift=0; 
end

if (min(y_min) <= k_size/2)
    y_shift = ceil(k_size/2 - min(y_min) + 1); 
else
    y_shift=0; 
end

% Shift the retroflow values for the full image series.
for j = 1:t
    list = list_cell{j};
    list(:,2) = list(:,2) + y_shift;
    list(:,1) = list(:,1) + x_shift;
    list_cell{j} = list;
end

% Define the k_size_temp+1 (e.g 5) layer thick convolution array block 
% that is moved through the full image series in the analysis.
x = max(x);
y = max(y);
im_x(1:y + k_size + 1 + y_shift, 2:x + k_size + 1 + x_shift, ...
    1:k_size_temp + 1) = 0;
im_devider = im_x;
im_y = im_x;

% Generate the convolution kernel, gaussian kernel, circular, 
% sigma of k_size/6.
[k_x, k_y] = meshgrid(-k_size/2:k_size/2, -k_size/2:k_size/2);
kernel_2D = exp(-(k_x.^2 + k_y.^2) / (2 * (k_sigma)^2));

for i = 1:k_size_temp/2 + 1
    kernel_3D(:,:,i) = kernel_2D * exp(-(k_size_temp/2 + 1 - i)^2 / ...
        (k_sigma_temp)^2);
    kernel_3D(:,:,k_size_temp - i + 2) = kernel_3D(:,:,i);
end
min_val = max(min(kernel_3D(:,:,k_size_temp/2 + 1)));
kernel_3D(kernel_3D < min_val) = 0;

startframe = 1;
endframe = max(size(list_cell));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Now that we have the unfiltered retroflow data, we can start the filtering
%Do the 3D convolution.
for j = startframe:endframe;
    list = list_cell{j};
    
    for i = 1:max(size(list));
        x_c = list(i,1);
        y_c = list(i,2);
        dx = list(i,3);
        dy = list(i,4);
        if(list(i,5) > xcorr_thresh)
            x_c = list(i,1);
            y_c = list(i,2);
            
            % Build the convolution matrix and the normalization matrices.
            im_x(y_c - (k_size/2):y_c + (k_size/2), ...
                x_c - (k_size/2):x_c + (k_size/2), :) = ...
                list(i,5) * list(i,3) * kernel_3D + ...
                im_x(y_c - (k_size/2):y_c + (k_size/2), ...
                x_c - (k_size/2):x_c + (k_size/2), :);
            
            im_y(y_c - (k_size/2):y_c + (k_size/2), ...
                x_c - (k_size/2):x_c + (k_size/2), :) = ...
                list(i,5) * list(i,4) * kernel_3D + ...
                im_y(y_c - (k_size/2):y_c + (k_size/2), ...
                x_c - (k_size/2):x_c + (k_size/2), :);
            
            im_devider(y_c - (k_size/2):y_c + (k_size/2), ...
                x_c - (k_size/2):x_c + (k_size/2), :) = ...
                list(i,5) * kernel_3D + ...
                im_devider(y_c - (k_size/2):y_c + (k_size/2), ...
                x_c - (k_size/2):x_c + (k_size/2), :);
        end
    end
    im_x_act = single(im_x(:,:,1) ./ im_devider(:,:,1));
    im_y_act = single(im_y(:,:,1) ./ im_devider(:,:,1));
    
    % Create image and save final values (starts at frame k_size_temp/2 + 1 
    % because of time filtering).
    if j > startframe-1+k_size_temp/2
        i = j - k_size_temp / 2;
        
        % Create the image, plus get the filtered final results.
        % Load current frame.
        im = imread(fullfile(handles.path2tif, handles.mov_file), i);
        try
            im = im(:, :, get(handles.im_channel_, 'Value'));
        catch
        end
        im = double(im) / 255;
        
        % Detect cell outline for current frame.
        edge_alg = get(handles.edge_alg_, 'String');
        im_edge = edge(im, edge_alg{get(handles.edge_alg_, 'Value')});
        im_edge = imdilate(im_edge, ...
            strel('disk', ...
            str2double(get(handles.dilation_size_, 'String'))));
        im_edge = imfill(im_edge, 4, 'holes');
        im_edge = imerode(im_edge, ...
            strel('disk', ...
            str2double(get(handles.erosion_size_, 'String'))));
        
        % Create flow heatmaps.
        [vfilt(i).vx, vfilt(i).vy] = create_retro_flow_image(handles.main_fig, ...
            handles.path2tif, im, im_edge, im_x_act, im_y_act, x_shift, ...
            y_shift, mue2pix_ratio, max_flow_vel, ...
            flow_field_arrow_distance, handles.token, handles.running_tag);
    end
    
    % Delete first time layer of convolution array block and define next one
    im_x(:,:,1) = [];
    im_y(:,:,1) = [];
    im_devider(:,:,1) = [];
    im_x(:,:,k_size_temp + 1) = 0;
    im_y(:,:,k_size_temp + 1) = 0;
    im_devider(:,:,k_size_temp + 1) = 0;
    
    % Create the last image save final values (has to be done differently because of time filtering)
    if j == max(size(list_cell)); %this means the last 2 frames run again but its easy this way
        for n = 1:k_size_temp/2
            i = j - k_size_temp / 2 + n;
            im_x_act = single(im_x(:,:,n) ./ im_devider(:,:,n));
            im_y_act = single(im_y(:,:,n) ./ im_devider(:,:,n));
            
            %  Create the image, plus get the filtered final results
            [vfilt(i).vx, vfilt(i).vy] = create_retro_flow_image(handles.main_fig, ...
                handles.path2tif, im, im_edge, im_x_act, im_y_act, x_shift, ...
                y_shift, mue2pix_ratio, max_flow_vel, ...
                flow_field_arrow_distance, handles.token, ...
                handles.running_tag);
        end
    end
end

% Save interpolated flow data to .mat file.
save(fullfile(handles.path2tif, 'data', ...
    ['piv_flow_interpl_', handles.token, '_', handles.running_tag, '.mat']), ...
    'vfilt');