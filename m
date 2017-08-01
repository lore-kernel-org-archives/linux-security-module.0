From: jmorris@namei.org (James Morris)
Date: Tue, 1 Aug 2017 10:54:07 +1000 (AEST)
Subject: [PATCH v4 00/15] exec: Use sane stack rlimit under secureexec
In-Reply-To: <CAGXu5j+hdDXA99raDRu1x5M3XuPN6TM0AfxXmJe=qGUDZWPeEQ@mail.gmail.com>
References: <1501545093-56634-1-git-send-email-keescook@chromium.org>
	<CAGXu5j+hdDXA99raDRu1x5M3XuPN6TM0AfxXmJe=qGUDZWPeEQ@mail.gmail.com>
Message-ID: <alpine.LRH.2.20.1708011053210.6845@namei.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Mon, 31 Jul 2017, Kees Cook wrote:

> Ugh, please ignore this v4. There's a typo that snuck in. I'll send a v5 soon...

Aside from that, it's looking good. This touches a lot of stuff in 
security/ so it may make sense for it to go in via my tree.


-- 
James Morris
<jmorris@namei.org>

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
