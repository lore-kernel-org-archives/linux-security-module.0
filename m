From: keescook@chromium.org (Kees Cook)
Date: Tue, 1 Aug 2017 08:04:54 -0700
Subject: [PATCH v4 00/15] exec: Use sane stack rlimit under secureexec
In-Reply-To: <CA+55aFyudxKya3aVa5sQRiMH0TrP0SyNvyT+q8geJ47m3xfdKA@mail.gmail.com>
References: <1501545093-56634-1-git-send-email-keescook@chromium.org>
	<CAGXu5j+hdDXA99raDRu1x5M3XuPN6TM0AfxXmJe=qGUDZWPeEQ@mail.gmail.com>
	<alpine.LRH.2.20.1708011053210.6845@namei.org>
	<CAGXu5jJ+UYXa3VxAghMwNfEsZ2g7PHJkdU7_SCCgOg9XEvy5Yw@mail.gmail.com>
	<CA+55aFyudxKya3aVa5sQRiMH0TrP0SyNvyT+q8geJ47m3xfdKA@mail.gmail.com>
Message-ID: <CAGXu5jJafQh84hPwy234b=nwCAwdsnx=Dz3GJ5voJLGSt3xwgQ@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Mon, Jul 31, 2017 at 10:11 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Mon, Jul 31, 2017 at 8:03 PM, Kees Cook <keescook@chromium.org> wrote:
>>
>> Yeah, I'm open to whatever. It's not clear where it should go, but if
>> you want to take it and Linus doesn't want it "early", that works for
>> me. Linus, Andrew, thoughts?
>
> I'd actually like this to go in separately from all the other security stuff.
>
> And I just checked this on a separate branch, just because I wanted to
> see what the overall diff was. There's a conflict with apparmor
> already - the resolution looks fairly straightforward, but considering
> the area this touches, it would probably be good that Kees keeps this
> branch and verifies things like that.

Do you want me to carry this for -next and send it as a distinct pull
request for v4.14?

-Kees

-- 
Kees Cook
Pixel Security
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
