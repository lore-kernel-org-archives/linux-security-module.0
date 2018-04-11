From: dhowells@redhat.com (David Howells)
Date: Wed, 11 Apr 2018 21:05:56 +0100
Subject: [PATCH 06/24] kexec_load: Disable at runtime if the kernel is
	locked down
In-Reply-To: <87po35k1q6.fsf@xmission.com>
References: <87po35k1q6.fsf@xmission.com>
	<152346387861.4030.4408662483445703127.stgit@warthog.procyon.org.uk>
	<152346391877.4030.6270466586590461223.stgit@warthog.procyon.org.uk>
Message-ID: <12601.1523477156@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Eric W. Biederman <ebiederm@xmission.com> wrote:

> Maybing I am missing it but I am not seeing anything that would require
> kexec_file_load be configured such that it checks the loaded kernel.
> 
> Without that I don't see the point of disabling kexec_load.

I meant to remove this patch too.

David
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
