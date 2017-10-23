From: dhowells@redhat.com (David Howells)
Date: Mon, 23 Oct 2017 15:58:23 +0100
Subject: [PATCH 26/27] efi: Add an EFI_SECURE_BOOT flag to indicate secure
	boot mode
In-Reply-To: <alpine.LFD.2.20.1710210618180.22771@t440>
References: <alpine.LFD.2.20.1710210618180.22771@t440>
	<150842463163.7923.11081723749106843698.stgit@warthog.procyon.org.uk>
	<150842483172.7923.2791223614506312745.stgit@warthog.procyon.org.uk>
Message-ID: <23162.1508770703@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

James Morris <james.l.morris@oracle.com> wrote:

> > +		default:
> > +			pr_info("Secure boot could not be determined\n");
> 
> Perhaps make this pr_warning and include the unknown mode value?

Done.

David
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
