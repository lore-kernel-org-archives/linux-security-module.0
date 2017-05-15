From: keescook@chromium.org (Kees Cook)
Date: Mon, 15 May 2017 10:33:55 -0700
Subject: [PATCH 00/17] convert/reorganize Documentation/security/
In-Reply-To: <20170515112621.38aef111@lwn.net>
References: <1494676313-144890-1-git-send-email-keescook@chromium.org>
	<20170515112621.38aef111@lwn.net>
Message-ID: <CAGXu5jJtpYwzhMz2wj=zcRy0VKhg8NiFz=ZxDccRqfAPX4hkAA@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Mon, May 15, 2017 at 10:26 AM, Jonathan Corbet <corbet@lwn.net> wrote:
> On Sat, 13 May 2017 04:51:36 -0700
> Kees Cook <keescook@chromium.org> wrote:
>
>> This ReSTifies everything under Documentation/security/, and reorganizes
>> some of it (mainly the LSMs) under /admin-guide/ per Jon's request. Since
>> /security/ is already being indexed under the kernel development portion
>> of the sphinx index, I didn't move it, keeping only things that were
>> directly related to internal kernel development (keys, creds, etc).
>>
>> I also updated some path references, and MAINTAINERS lines. Some of the
>> conversion could probably do with some tweaks, but I think this is a
>> good first step in the right direction.
>
> This all looks pretty good to me, though I'll confess I haven't actually
> built the resulting docs yet.  Assuming no issues turn up there, I'd be
> happy to just apply these and let any follow-on tweaks go from there.
> Thanks for doing this, and for humoring me on the organizational issues :)

My local tree builds the docs sanely from what I can see, so if it
looks good to you too, yeah, please take these as they are. I'm sure
we'll need tweaks going forward, but this seems like the bulk of the
organizational and basic ReST work.

BTW, something I noticed in while doing this conversion is the
difference between the section headings and the left-side nav bar at
the top level:
https://www.kernel.org/doc/html/latest/index.html

The section names don't match, and each of the Kernel API
Documentation sections is at the top level in the nav bar. I think
this would be cleaner if everything matched up, but I didn't yet dig
into figuring out why they were different.

-Kees

-- 
Kees Cook
Pixel Security
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
