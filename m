From: dhowells@redhat.com (David Howells)
Date: Wed, 09 Aug 2017 09:28:43 +0100
Subject: [PATCH 0/3] Fix y2038 issues for security/keys subsystem
In-Reply-To: <cover.1502246501.git.baolin.wang@linaro.org>
References: <cover.1502246501.git.baolin.wang@linaro.org>
Message-ID: <4455.1502267323@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

The rxrpc patch isn't part of the security/keys subsystem.  I'll push it
to the network tree.  The other two I'll push to James.

David
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
