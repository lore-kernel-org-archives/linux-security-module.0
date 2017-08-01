From: torvalds@linux-foundation.org (Linus Torvalds)
Date: Mon, 31 Jul 2017 22:14:23 -0700
Subject: [PATCH v4 00/15] exec: Use sane stack rlimit under secureexec
In-Reply-To: <CA+55aFyudxKya3aVa5sQRiMH0TrP0SyNvyT+q8geJ47m3xfdKA@mail.gmail.com>
References: <1501545093-56634-1-git-send-email-keescook@chromium.org>
	<CAGXu5j+hdDXA99raDRu1x5M3XuPN6TM0AfxXmJe=qGUDZWPeEQ@mail.gmail.com>
	<alpine.LRH.2.20.1708011053210.6845@namei.org>
	<CAGXu5jJ+UYXa3VxAghMwNfEsZ2g7PHJkdU7_SCCgOg9XEvy5Yw@mail.gmail.com>
	<CA+55aFyudxKya3aVa5sQRiMH0TrP0SyNvyT+q8geJ47m3xfdKA@mail.gmail.com>
Message-ID: <CA+55aFw=61Df1SmnEDrjg9zLHL1u3GmdnKQD=f6cZ7-kp1a+tw@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Mon, Jul 31, 2017 at 10:11 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> And I just checked this on a separate branch, just because I wanted to
> see what the overall diff was. There's a conflict [..]

Side note: the overall patch looks fine to me. I like how it removes
complexity and code. I didn't test it (other than test *building* the
merge), so take that for what it's worth, but at least the patches
look sensible both on an individual level and as an end result.

                   Linus
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
