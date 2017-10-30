From: dhowells@redhat.com (David Howells)
Date: Mon, 30 Oct 2017 17:00:34 +0000
Subject: [PATCH 03/27] Enforce module signatures if the kernel is locked
	down
In-Reply-To: <1509130095.3716.13.camel@linux.vnet.ibm.com>
References: <1509130095.3716.13.camel@linux.vnet.ibm.com>
	<150842463163.7923.11081723749106843698.stgit@warthog.procyon.org.uk>
	<150842465546.7923.6762214527898273559.stgit@warthog.procyon.org.uk>
Message-ID: <3565.1509382834@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:

> This kernel_is_locked_down() check is being called for both the
> original and new module_load syscalls. ?We need to be able
> differentiate them. ?This is fine for the original syscall, but for
> the new syscall we would need an additional IMA check -
> !is_ima_appraise_enabled().

IMA can only be used with finit_module()?

David
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
