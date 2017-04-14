From: dhowells@redhat.com (David Howells)
Date: Sat, 15 Apr 2017 00:16:24 +0100
Subject: [PATCH 06/24] Add a sysrq option to exit secure boot mode
In-Reply-To: <CAKv+Gu-FDzdqACyr_z6Zsgb51mg8Lc0YgfLs4oGURWnX4WewSw@mail.gmail.com>
References: <CAKv+Gu-FDzdqACyr_z6Zsgb51mg8Lc0YgfLs4oGURWnX4WewSw@mail.gmail.com>
	<149142326734.5101.4596394505987813763.stgit@warthog.procyon.org.uk>
	<149142332458.5101.14654616837280513947.stgit@warthog.procyon.org.uk>
	<alpine.DEB.2.20.1704142003570.2327@nanos>
Message-ID: <12411.1492211784@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:

> That does bring me to another EFI related point: many of these patches
> are x86 specific for no good reason.

Note that the sysrq one is awkward since the key chosen *is* arch-specific.
SysRq+x can't be arbitrarily assigned to this since some other arches have
their own use for it.

Anyway, the ones that are x86-specific are:

	efi: Add EFI_SECURE_BOOT bit
	efi: Lock down the kernel if booted in secure boot mode
	Add a sysrq option to exit secure boot mode
	Copy secure_boot flag in boot params across kexec reboot
	x86: Lock down IO port access when the kernel is locked down
	x86: Restrict MSR access when the kernel is locked down
	asus-wmi: Restrict debugfs interface when the kernel is locked down

The first three are dealt with in the five patches I posted later, including
making the choice of sysrq key an arch override.  The bits that can be moved
out to the efi firmware driver have been.

The 4th looks to be x86 bootloader protocol specific.

The remainder look very x86 specific, apart from one piece in the 5th patch
where /dev/port is locked down.

David
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
