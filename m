From: corbet@lwn.net (Jonathan Corbet)
Date: Mon, 1 May 2017 09:11:59 -0600
Subject: converting Documentation/security/* to .rst
In-Reply-To: <CAGXu5j+YuXd70ZCNBJRfQNXwMqSPgVaqEyaq_yXkbgje3-gdVg@mail.gmail.com>
References: <CAGXu5j+YuXd70ZCNBJRfQNXwMqSPgVaqEyaq_yXkbgje3-gdVg@mail.gmail.com>
Message-ID: <20170501091159.63218239@lwn.net>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Fri, 28 Apr 2017 13:24:36 -0700
Kees Cook <keescook@google.com> wrote:

> I was curious if the conversion of security/ (and prctl/ which only
> has two files that should probably both be moved to security/) was
> already on someone's TODO list? I'd love to get these done (I refer
> people regularly to seccomp_filter.txt and self-protection.txt), but I
> didn't want to duplicate any efforts.

If anybody is working in that area, they've not told me about it.

> I read about various tools to help with auto-converting files to kind
> of help speed up the process, but I couldn't find what seemed a
> canonical answer to what to use as a helper. Is there one? (Perhaps
> this was only for DocBook?)

The tools, such as they are, are for the conversion of DocBook template
files.  Most of the kernel's .txt files are already in something quite
close to RST already, so the conversion is trivial.

The real question would be one of organization.  Most of the security
stuff looks like it properly belongs in the admin guide, but that's not
universally the case.

Thanks,

jon
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
