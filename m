From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Mon, 30 Oct 2017 13:52:16 -0400
Subject: [PATCH 03/27] Enforce module signatures if the kernel is locked
	down
In-Reply-To: <3565.1509382834@warthog.procyon.org.uk>
References: <1509130095.3716.13.camel@linux.vnet.ibm.com>
	<150842463163.7923.11081723749106843698.stgit@warthog.procyon.org.uk>
	<150842465546.7923.6762214527898273559.stgit@warthog.procyon.org.uk>
	<3565.1509382834@warthog.procyon.org.uk>
Message-ID: <1509385936.3583.170.camel@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

[Corrected Matthew Garrett's email address. ?Cc'ed Bruno Meneguele]

On Mon, 2017-10-30 at 17:00 +0000, David Howells wrote:
> Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> 
> > This kernel_is_locked_down() check is being called for both the
> > original and new module_load syscalls. ?We need to be able
> > differentiate them. ?This is fine for the original syscall, but for
> > the new syscall we would need an additional IMA check -
> > !is_ima_appraise_enabled().
> 
> IMA can only be used with finit_module()?

Yes, without the file descriptor, IMA-appraisal can't access the
xattrs.?

You should really look at Bruno's patches, which are in my next
branch:

8168913c50d5 "ima: check signature enforcement against cmdline param instead of CONFIG"
404090509894 module: export module signature enforcement status

Can we get an Ack on the module one?

Mimi

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
