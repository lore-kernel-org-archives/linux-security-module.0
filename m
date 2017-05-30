From: jmorris@namei.org (James Morris)
Date: Tue, 30 May 2017 20:22:57 +1000 (AEST)
Subject: [PATCH] LSM: Convert security_hook_heads into explicit array of
	struct list_head
In-Reply-To: <201705281026.EHD04622.HJFOLQFMSOtFOV@I-love.SAKURA.ne.jp>
References: <1495883858-3336-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
	<CAGXu5jJ045iaDfoW+2dXU+U-KhfnNH1WX5ngUW9dHyS5Yn3EGg@mail.gmail.com>
	<201705281026.EHD04622.HJFOLQFMSOtFOV@I-love.SAKURA.ne.jp>
Message-ID: <alpine.LRH.2.20.1705302021090.31018@namei.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Sun, 28 May 2017, Tetsuo Handa wrote:

> can afford enabling". And we know that we cannot merge all security modules
> into mainline. Thus, allowing LKM-based LSM modules is inevitable.

Nope, it's not inevitable.  The LSM API only caters to in-tree users.

I'm not sure why you persist against this.


-- 
James Morris
<jmorris@namei.org>

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
