Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b="Ub25VtVY"
X-Greylist: delayed 1564 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 22 Nov 2023 04:22:19 PST
Received: from imap4.hz.codethink.co.uk (imap4.hz.codethink.co.uk [188.40.203.114])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 939E7197
	for <linux-security-module@vger.kernel.org>; Wed, 22 Nov 2023 04:22:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codethink.co.uk; s=imap4-20230908; h=Sender:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=yhCcK0wRZ/D1OEdibIwHIFgo6z7azJAhavEvkkBIAX8=; b=Ub25VtVYY2/ZmqxVJ3EemcELNr
	yWZmXZIMc0mkevEphpYIHS1bV6IOAPbAPw40MSNI5WaovJ9lcA5y9rX3LOo/YVbisecrrUANRvfuA
	HOU4x2caPyL4hbrGuOxSqxZs9R9u6fxTTLYZHCYeNFQxiAm6ChFeQDrom4Kp5k4CtmtuK8JURbkne
	zQuRy+sZptW8RhECUv5Gdml0hF+ko7prQjlt690IZOnhsjZz+XhU19f+xvj7zfht6hsJ0rNjWsMDD
	iT+J52SW0/trn1EoaeZSbpJu6X67UmDxoFcmYlBIWg28+SIo+863gatbV3eUIOVLF9SnGj1vGy+L4
	g4YkPKuA==;
Received: from [167.98.27.226] (helo=rainbowdash)
	by imap4.hz.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
	id 1r5lq0-003nX6-8U; Wed, 22 Nov 2023 11:56:13 +0000
Received: from ben by rainbowdash with local (Exim 4.97)
	(envelope-from <ben@rainbowdash>)
	id 1r5lq0-00000001CJ4-36MO;
	Wed, 22 Nov 2023 11:56:12 +0000
From: Ben Dooks <ben.dooks@codethink.co.uk>
To: apparmor@lists.ubuntu.com
Cc: linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH] apparmor: make stack_msg static
Date: Wed, 22 Nov 2023 11:56:11 +0000
Message-Id: <20231122115611.285625-1-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.37.2.352.g3c44437643
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: srv_ts003@codethink.com

The stack_msg is not exported out of security/apparmor/domain.c so
make it static to avoid the following sparse warning:

security/apparmor/domain.c:1314:12: warning: symbol 'stack_msg' was not declared. Should it be static?

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 security/apparmor/domain.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/apparmor/domain.c b/security/apparmor/domain.c
index 89fbeab4b33b..571158ec6188 100644
--- a/security/apparmor/domain.c
+++ b/security/apparmor/domain.c
@@ -1311,7 +1311,7 @@ static int change_profile_perms_wrapper(const char *op, const char *name,
 	return error;
 }
 
-const char *stack_msg = "change_profile unprivileged unconfined converted to stacking";
+static const char *stack_msg = "change_profile unprivileged unconfined converted to stacking";
 
 /**
  * aa_change_profile - perform a one-way profile transition
-- 
2.37.2.352.g3c44437643

