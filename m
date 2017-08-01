From: keescook@chromium.org (Kees Cook)
Date: Mon, 31 Jul 2017 20:03:49 -0700
Subject: [PATCH v4 00/15] exec: Use sane stack rlimit under secureexec
In-Reply-To: <alpine.LRH.2.20.1708011053210.6845@namei.org>
References: <1501545093-56634-1-git-send-email-keescook@chromium.org>
	<CAGXu5j+hdDXA99raDRu1x5M3XuPN6TM0AfxXmJe=qGUDZWPeEQ@mail.gmail.com>
	<alpine.LRH.2.20.1708011053210.6845@namei.org>
Message-ID: <CAGXu5jJ+UYXa3VxAghMwNfEsZ2g7PHJkdU7_SCCgOg9XEvy5Yw@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Mon, Jul 31, 2017 at 5:54 PM, James Morris <jmorris@namei.org> wrote:
> On Mon, 31 Jul 2017, Kees Cook wrote:
>
>> Ugh, please ignore this v4. There's a typo that snuck in. I'll send a v5 soon...
>
> Aside from that, it's looking good. This touches a lot of stuff in
> security/ so it may make sense for it to go in via my tree.

Yeah, I'm open to whatever. It's not clear where it should go, but if
you want to take it and Linus doesn't want it "early", that works for
me. Linus, Andrew, thoughts?

-Kees

-- 
Kees Cook
Pixel Security
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
