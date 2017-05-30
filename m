From: gnomes@lxorguk.ukuu.org.uk (Alan Cox)
Date: Tue, 30 May 2017 16:25:50 +0100
Subject: [PATCH] LSM: Convert security_hook_heads into explicit array of
	struct list_head
In-Reply-To: <201705302329.IEB05735.FLJOFHSQVtOOFM@I-love.SAKURA.ne.jp>
References: <1495883858-3336-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
	<CAGXu5jJ045iaDfoW+2dXU+U-KhfnNH1WX5ngUW9dHyS5Yn3EGg@mail.gmail.com>
	<201705281026.EHD04622.HJFOLQFMSOtFOV@I-love.SAKURA.ne.jp>
	<alpine.LRH.2.20.1705302021090.31018@namei.org>
	<201705302329.IEB05735.FLJOFHSQVtOOFM@I-love.SAKURA.ne.jp>
Message-ID: <20170530162550.19ba1811@alans-desktop>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, 30 May 2017 23:29:10 +0900
Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp> wrote:

> James Morris wrote:
> > On Sun, 28 May 2017, Tetsuo Handa wrote:
> >   
> > > can afford enabling". And we know that we cannot merge all security modules
> > > into mainline. Thus, allowing LKM-based LSM modules is inevitable.  
> > 
> > Nope, it's not inevitable.  The LSM API only caters to in-tree users.
> > 
> > I'm not sure why you persist against this.  
> 
> Then, we are willing to accept LSM modules with users less than 10, aren't we?

Why not if they are properly written and maintained. Historically we've
supported an entire architecture that had one machine ever built. We
supported a strange subclass of x86 machines for many years because James
Bottomley cared enough to do the work. We still support M68K, PA-RISC and
other stuff as well as plenty of hardware which probably has few users -
providing it doesn't cause maintenance problems.

Alan
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
