From: dhowells@redhat.com (David Howells)
Date: Tue, 16 Jan 2018 16:31:51 +0000
Subject: [PATCH 08a/30] kexec_file: split KEXEC_VERIFY_SIG into KEXEC_SIG
	and KEXEC_SIG_FORCE
In-Reply-To: <20180111120157.23qceywzi6omvvkb@dwarf.suse.cz>
References: <20180111120157.23qceywzi6omvvkb@dwarf.suse.cz>
	<151024863544.28329.2436580122759221600.stgit@warthog.procyon.org.uk>
	<151024869793.28329.4817577607302613028.stgit@warthog.procyon.org.uk>
	<20180111115915.dejachty3l7fwpmf@dwarf.suse.cz>
Message-ID: <4582.1516120311@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

I think that your code isn't quite right.  Looking at the patched code:

    #ifdef CONFIG_KEXEC_SIG
	sig_err = arch_kexec_kernel_verify_sig(image, image->kernel_buf,
					   image->kernel_buf_len);
	if (sig_err)
		pr_debug("kernel signature verification failed.\n");
	else
		pr_debug("kernel signature verification successful.\n");
    #endif

	if (sig_err && IS_ENABLED(CONFIG_KEXEC_SIG_FORCE)) {
		ret = sig_err;
		goto out;
	}

If the signature check fails because the signature is bad, but
CONFIG_KEXEC_SIG_FORCE=n then it now won't fail when it should.

If sig_err is -EKEYREJECTED, -EKEYEXPIRED or -EKEYREVOKED then it must fail,
even if the signature check isn't forced.

David
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
