import numpy as np
import pyautogui
import cv2
from test.test_file import PyAutoFileTests

def draw_board():
    # Create a black image
    img = np.zeros((618,618,3), np.uint8)     
    # Draw a diagonal blue line with thickness of 5 px
    cv2.line(img,(205,0),(205,615),(255,0,0),5)
    cv2.line(img,(410,0),(410,615),(255,0,0),5)
    cv2.line(img,(0,205),(615,205),(255,0,0),5)
    cv2.line(img,(0,410),(615,410),(255,0,0),5)
    return img
def draw_move(x,y,ruch):
    if ruch == 'X':
        cv2.line(obraz,(x-90,y-90),(x+90,y+90),(0,0,255),5)
        cv2.line(obraz,(x-90,y+90),(x+90,y-90),(0,0,255),5)
        ruch = 'O'
    elif ruch == 'O':
        cv2.circle(obraz,(x,y),90,(0,255,0),5)
        ruch = 'X'
    print('Tura: ', ruch)
def check_position(event,x,y,flag,params):
    if event == cv2.EVENT_LBUTTONDOWN:
        ruch = 'X'
        dimension_x = [[0,202],[208,410],[416,618]]
        dimension_y = [[0,202],[208,410],[416,618]]
        print('X = ',x,', Y = ',y)
        if   x > dimension_x[0][0] and x < dimension_x[0][1]:
            out_x = 102
        elif x > dimension_x[1][0] and x < dimension_x[1][1]:
            out_x = 309
        elif x > dimension_x[2][0] and x < dimension_x[2][1]:
            out_x = 517
        else:
            out_x = -1
            
        if   y > dimension_y[0][0] and y < dimension_y[0][1]:
            out_y = 102
        elif y > dimension_y[1][0] and y < dimension_y[1][1]:
            out_y = 309
        elif y > dimension_y[2][0] and y < dimension_y[2][1]:
            out_y = 517
        else:
            out_y = -1
        if out_x == -1 or out_y == -1:
            pass
        else:
            draw_move(out_x,out_y,ruch)    

obraz = draw_board()
cv2.namedWindow('okno_obraz')
cv2.setMouseCallback('okno_obraz',check_position)
ruch = 'X'
while(1):
    x,y = pyautogui.position()
    #print('X = ',x,', Y = ',y)
    #obraz,ruch = draw_move(100,100,ruch)
    cv2.imshow('okno_obraz',obraz)
    if cv2.waitKey(20) & 0xFF == 27:
        break
cv2.destroyAllWindows()
