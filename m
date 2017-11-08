From: dhowells@redhat.com (David Howells)
Date: Wed, 08 Nov 2017 13:30:50 +0000
Subject: [PATCH v5 2/4] KEYS: Add ELF class-independent certificate
	insertion support
In-Reply-To: <1494440456-28671-3-git-send-email-mkayaalp@linux.vnet.ibm.com>
References: <1494440456-28671-3-git-send-email-mkayaalp@linux.vnet.ibm.com>
	<1494440456-28671-1-git-send-email-mkayaalp@linux.vnet.ibm.com>
Message-ID: <18400.1510147850@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

This patch may need to add elfutils to the list of minimal requirements in:

	Documentation/process/changes.rst

David
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
