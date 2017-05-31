From: jobol@nonadev.net (=?UTF-8?B?Sm9zw6k=?= Bollo)
Date: Wed, 31 May 2017 11:44:17 +0200
Subject: [PATCH] LSM: Convert security_hook_heads into explicit array of
	struct list_head
In-Reply-To: <201705302329.IEB05735.FLJOFHSQVtOOFM@I-love.SAKURA.ne.jp>
References: <1495883858-3336-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
	<CAGXu5jJ045iaDfoW+2dXU+U-KhfnNH1WX5ngUW9dHyS5Yn3EGg@mail.gmail.com>
	<201705281026.EHD04622.HJFOLQFMSOtFOV@I-love.SAKURA.ne.jp>
	<alpine.LRH.2.20.1705302021090.31018@namei.org>
	<201705302329.IEB05735.FLJOFHSQVtOOFM@I-love.SAKURA.ne.jp>
Message-ID: <20170531114417.5a7d8bcb@d-jobol.iot.bzh>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, 30 May 2017 23:29:10 +0900
Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp> wrote:

> James Morris wrote:
> > On Sun, 28 May 2017, Tetsuo Handa wrote:
> >   
> > > can afford enabling". And we know that we cannot merge all
> > > security modules into mainline. Thus, allowing LKM-based LSM
> > > modules is inevitable.  
> > 
> > Nope, it's not inevitable.  The LSM API only caters to in-tree
> > users.
> > 
> > I'm not sure why you persist against this.  
> 
> Then, we are willing to accept LSM modules with users less than 10,
> aren't we? Forcing users to patch and recompile is as heartless as
> forcing CONFIG_MODULES=n.

These are good reasons. I'm in favor of Tetsuo.

Regards
Jos?
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
