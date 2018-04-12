From: luto@amacapital.net (Andy Lutomirski)
Date: Wed, 11 Apr 2018 19:57:12 -0700
Subject: [PATCH 01/24] Add the ability to lock down access to the running
	kernel image
In-Reply-To: <152346388583.4030.15146667041427303547.stgit@warthog.procyon.org.uk>
References: <152346387861.4030.4408662483445703127.stgit@warthog.procyon.org.uk>
	<152346388583.4030.15146667041427303547.stgit@warthog.procyon.org.uk>
Message-ID: <CALCETrUaSeTwwiTs7LwNTcScUcVok1_j-OBnEQqGXmst5T++Sg@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, Apr 11, 2018 at 9:24 AM, David Howells <dhowells@redhat.com> wrote:
>
>  (*) CONFIG_LOCK_DOWN_KERNEL
>
>      This makes lockdown available and applies it to all the points that
>      need to be locked down if the mode is set.  Lockdown mode can be
>      enabled by providing:
>
>         lockdown=1

By doing this, you are basically committing to making the
protect-kernel-integrity vs protect-kernel-secrecy split be a
second-class citizen if it gets added.

How about lockdown=integrity_and_secrecy or lockdown=2 if you feel
like using numbers?
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
