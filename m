From: keescook@chromium.org (Kees Cook)
Date: Tue, 9 May 2017 09:12:51 -0700
Subject: [PATCH] key: Convert big_key payload.data to struct
In-Reply-To: <14829.1494317484@warthog.procyon.org.uk>
References: <20170508214324.GA124468@beast>
	<10235.1494280856@warthog.procyon.org.uk>
	<CAGXu5jLYLeYWm9GKMm2_5iT4PjaXCi5qsGnZQ2JqFT0DVvmYog@mail.gmail.com>
	<14829.1494317484@warthog.procyon.org.uk>
Message-ID: <CAGXu5jJZtQ4AB+zwDq6sDCn95HrLTCE2maz5FNs0qZk50m51Lw@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, May 9, 2017 at 1:11 AM, David Howells <dhowells@redhat.com> wrote:
> Kees Cook <keescook@chromium.org> wrote:
>
>> This doesn't protect you against changes in struct path size,
>> though... the existing code (and this proposal) will break if that
>> ever happens...
>
> True - in which case you should kmalloc() it as Eric suggests.
>
>> What's the problem with defining the types at the top level? That
>> seems like a nice place to see them all at once.
>
> It means adding a bunch of dependencies to linux/key.h and union key_payload.
>
> Have you considered why we don't just put all the definitions for all the
> filesystems in linux/fs.h?  By this logic it would seem like a nice place to
> see them all at once.

I've seen other things that want to share a structure use embedded
structures, etc. I'll see if there is something else to be done, but
just cleaning up the casts alone makes the big_key code so much more
readable. :P

-Kees

-- 
Kees Cook
Pixel Security
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
