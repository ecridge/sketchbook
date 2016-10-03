/*
 * Pentatonic (1.0.1 and later)
 * 
 * Author: Joe Edan Cridge 
 * Purpose: to entertain
 * 
 * You may pass on, copy and distribute this as you wish, so long as
 * none of the original content is changed or edited - and that this
 * this notice and the copyright string are present (and not edited
 * in any way). Thanks, and enjoy.
 *
 * NOTE: Pentatonic will only run properly if it and all of its
 * 	 contents are stored under the correct names and in the
 *	 correct directory.
 *
 * Copyright Joe Cridge, 2008. 	
 */



import java.applet.*;
import java.awt.*;
import java.awt.event.*;

public class Pentatonic extends Applet implements KeyListener {
	
	Image bg1;
	AudioClip intro1, C1, D1, F1, G1, A1, C12, C2, D2, F2, G2, A2, C3, Bb1, Bb2;
	
	public void init() {	
		intro1 = getAudioClip(getDocumentBase(), "intro.au");
		bg1 = getImage(getDocumentBase(), "pentatonicbg.jpg"); 

		C1 = getAudioClip(getDocumentBase(), "C.au");
		D1 = getAudioClip(getDocumentBase(), "D.au");
		F1 = getAudioClip(getDocumentBase(), "F.au");
		G1 = getAudioClip(getDocumentBase(), "G.au");
		A1 = getAudioClip(getDocumentBase(), "A.au");

		C2 = getAudioClip(getDocumentBase(), "CC.au");
		D2 = getAudioClip(getDocumentBase(), "DD.au");
		F2 = getAudioClip(getDocumentBase(), "FF.au");
		G2 = getAudioClip(getDocumentBase(), "GG.au");
		A2 = getAudioClip(getDocumentBase(), "AA.au");
		C3 = getAudioClip(getDocumentBase(), "CCC.au");

		Bb1 = getAudioClip(getDocumentBase(), "Bb.au");
		Bb2 = getAudioClip(getDocumentBase(), "BbBb.au");
		intro1.play();
		addKeyListener(this);
	}

	public void keyPressed(KeyEvent e) { }
	public void keyReleased(KeyEvent e) { }
	public void keyTyped(KeyEvent e) {
		char c1 = e.getKeyChar();
		if (c1 == '=') intro1.play();
		else if (c1 == '1') C1.play();
		else if (c1 == '2') D1.play();
		else if (c1 == '3') F1.play();
		else if (c1 == '4') G1.play();
		else if (c1 == '5') A1.play();

		else if (c1 == '6') C2.play();
		else if (c1 == '7') D2.play();
		else if (c1 == '8') F2.play();
		else if (c1 == '9') G2.play(); 
		else if (c1 == '0') A2.play(); 
		else if (c1 == '-') C3.play();

		else if (c1 == 't') Bb1.play();
		else if (c1 == 'p') Bb2.play();
	}	

	public void paint(Graphics g) {
		g.drawImage(bg1, 0, 0, this);
		g.setColor(Color.yellow);
		g.drawString("Click to start!", 370, 420);
		g.drawString("Use any of the number keys to play.", 300, 440);  
		g.drawString("Copyright: Joe Cridge, 2008.", 10, 590);
		g.drawString("Pentatonic - Version 2.0.1", 620, 590);
	}

}
