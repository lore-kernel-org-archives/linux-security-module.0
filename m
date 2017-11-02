From: dhowells@redhat.com (David Howells)
Date: Thu, 02 Nov 2017 00:50:14 +0000
Subject: [PATCH 1/3] KEYS: return full count in keyring_read() if buffer
	is too small
In-Reply-To: <150958362347.7093.12077889134222746769.stgit@warthog.procyon.org.uk>
References: <150958362347.7093.12077889134222746769.stgit@warthog.procyon.org.uk>
Message-ID: <7366.1509583814@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Hi James,

Can you pass these fix patches onto Linus?

I'm holding onto Eric's doc update patch for a little longer as I suggested
some changes to it, but it's only documentation, no code changes.

Thanks,
David
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
