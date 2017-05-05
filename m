From: daniel.vetter@ffwll.ch (Daniel Vetter)
Date: Fri, 5 May 2017 23:54:41 +0200
Subject: converting Documentation/security/* to .rst
In-Reply-To: <20170503154247.3a8a9c4b@lwn.net>
References: <CAGXu5j+YuXd70ZCNBJRfQNXwMqSPgVaqEyaq_yXkbgje3-gdVg@mail.gmail.com>
	<20170501091159.63218239@lwn.net>
	<CAGXu5jKdE_WgdUQyJGBGfvGhxUES=FcuG_AsbqyKzuWTiq963g@mail.gmail.com>
	<20170503154247.3a8a9c4b@lwn.net>
Message-ID: <CAKMK7uFCWJfJTvGV57A2OuOji5kTUaPMJnW+Mxo7t9fvtrJxrQ@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, May 3, 2017 at 11:42 PM, Jonathan Corbet <corbet@lwn.net> wrote:
> On Mon, 1 May 2017 09:31:55 -0700
> Kees Cook <keescook@google.com> wrote:
>
>> > The real question would be one of organization.  Most of the security
>> > stuff looks like it properly belongs in the admin guide, but that's not
>> > universally the case.
>>
>> Are the index area "purposes" documented anywhere? The admin guide
>> seems to cover things outside of "administration" (like reporting
>> security bugs, which is a developer/researcher activity usually),
>> There's already a top-level "security documentation" with some TPM
>> stuff in it.
>
> They aren't really documented beyond what they, themselves, contain.  What
> you're seeing is the beginning of an effort to bring some order to the
> Documentation/ mess.  One of the biggest problems, IMO, is the lack of any
> sort of audience targeting.  We have lots of different kinds of people
> reading (we hope!) the docs, and they have to wade through a lot of
> irrelevant stuff.
>
> So we've set up guides for administrators, for kernel developers, and for
> user-space developers (the last just landing in 4.12).  There will never be
> a perfect spot for every document, but I hope we can create something
> that's more useful in the end.

Uuuhh... we might have torpedoed your efforts already in
Documenation/gpu/ Almost everything in there is for kernel developers
(gpu driver developers specifically), except we started to document
certain quirks and issues about the drm uapi in
Documentation/gpu/drm-uapi.rst. Much of that is again aimed at driver
developers (they need to implement the semantics correctly after all),
but it's also useful for userspace developers. And it might grow in
the future to include more.

How should we organize this? I admit that I'd like to keep it in
Documentation/gpu/ (because it is primarily aimed at kernel devs), but
at least linking it somewhere else might be useful?
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
