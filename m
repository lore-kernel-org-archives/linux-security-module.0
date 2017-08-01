From: keescook@chromium.org (Kees Cook)
Date: Tue, 1 Aug 2017 14:04:42 -0700
Subject: [PATCH v4 00/15] exec: Use sane stack rlimit under secureexec
In-Reply-To: <CA+55aFw0z0Zn6GdpfNSr=Zi-ApsDU1q0NR2cGTdZJtmyUiObAw@mail.gmail.com>
References: <1501545093-56634-1-git-send-email-keescook@chromium.org>
	<CAGXu5j+hdDXA99raDRu1x5M3XuPN6TM0AfxXmJe=qGUDZWPeEQ@mail.gmail.com>
	<alpine.LRH.2.20.1708011053210.6845@namei.org>
	<CAGXu5jJ+UYXa3VxAghMwNfEsZ2g7PHJkdU7_SCCgOg9XEvy5Yw@mail.gmail.com>
	<CA+55aFyudxKya3aVa5sQRiMH0TrP0SyNvyT+q8geJ47m3xfdKA@mail.gmail.com>
	<CAGXu5jJafQh84hPwy234b=nwCAwdsnx=Dz3GJ5voJLGSt3xwgQ@mail.gmail.com>
	<CA+55aFw0z0Zn6GdpfNSr=Zi-ApsDU1q0NR2cGTdZJtmyUiObAw@mail.gmail.com>
Message-ID: <CAGXu5jLYjMm78Q5Uei9Mc3RCGkpWU+QSXjDEQyYey=3P6OS50A@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, Aug 1, 2017 at 1:19 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Tue, Aug 1, 2017 at 8:04 AM, Kees Cook <keescook@chromium.org> wrote:
>>
>> Do you want me to carry this for -next and send it as a distinct pull
>> request for v4.14?
>
> Yes, I think that would be preferred. I consider this a "execve()"
> cleanup/change with implications for the security models rather than
> the other way around, so I'd rather keep it separate, and you already
> have a few other git trees so I think it makes sense to just treat it
> as another of your git pulls next merge window.

Okay, sounds good. Thanks!

-Kees

-- 
Kees Cook
Pixel Security
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
