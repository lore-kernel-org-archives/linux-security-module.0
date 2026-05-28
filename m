Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AEDB81732
	for <linux-security-module@vger.kernel.org>; Thu, 28 May 2026 03:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779937791; cv=none; b=b7pRAZ/g87lAh6xdqzVPqAKbTMOe1DnCfy+MK17r3ZbQZJ2XPqYGyGUFPBODntWJujwY+Rz+GtddHw6nYNXFePN5gRcpxfZ0qEWy75hTc3jkzTKlBmTlwJvhUdDpYG7CcY9ZdkbYMH0Q49oyTii5jV1gqBenbsuL9G9R/UwuKpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779937791; c=relaxed/simple;
	bh=yP54ld3NCtLGvt1XIfFMKP5tk/19fuQdSBFpCZTA28Q=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=epXx9rlA8ZaPNPniJI7c3yMRzIxP/jZRo15auZIOAzqhS6mPoCgTf4TxEbdbEHjUvc4nNyWel25E4RQQZ6LEJVYjd31xYcArQ1MQpGDZr86jf1VDaCnTtcNHCbGDHPx2scdIG05muAzsJjqsJ1fMl1Bcd1eGLYYOdV/G51MsoKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=OFnKBZYG; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="OFnKBZYG"
Received: from narnia.corp.microsoft.com (unknown [40.78.13.147])
	by linux.microsoft.com (Postfix) with ESMTPSA id 1290320B7167;
	Wed, 27 May 2026 20:09:37 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1290320B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1779937779;
	bh=aTfVZOYX1uwTjBGY0fMpK4WRTHS4wtk1vUHL84tFUO4=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=OFnKBZYGdvfvuaYEhOQfdVXbk6Nd4GsJa/HMcUQdsec+ZYunyUVTgpaLF54JEmBDH
	 8J+E/+zwY9c6I5qOGp9+zvSBqTOwVecIToYKIWW8PsoLl/383BhwbXXcYwxM/QgmOh
	 NoscU2lwxhnbMChupZcKn0ElKXkl21sSvIdqntd4=
From: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
To: "Jonathan Corbet" <corbet@lwn.net>,
	"Shuah Khan" <skhan@linuxfoundation.org>,
	"Paul Moore" <paul@paul-moore.com>,
	"James Morris" <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	"Eric Biggers" <ebiggers@kernel.org>,
	"Fan Wu" <wufan@kernel.org>,
	James.Bottomley@HansenPartnership.com,
	"Blaise Boscaccy" <bboscaccy@linux.microsoft.com>,
	linux-security-module@vger.kernel.org
Subject: [PATCH 08/11] hornet: gen_sig: fix missing command line switches
Date: Wed, 27 May 2026 20:08:17 -0700
Message-ID: <20260528030915.2654994-9-bboscaccy@linux.microsoft.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260528030915.2654994-1-bboscaccy@linux.microsoft.com>
References: <20260528030915.2654994-1-bboscaccy@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

D was missing from the getopt list. Additionally, we were missing the
help option handler.

Signed-off-by: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
---
 scripts/hornet/gen_sig.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/scripts/hornet/gen_sig.c b/scripts/hornet/gen_sig.c
index fb9ae1934206a..19ae9af006853 100644
--- a/scripts/hornet/gen_sig.c
+++ b/scripts/hornet/gen_sig.c
@@ -295,7 +295,7 @@ int main(int argc, char **argv)
 	int i;
 	int opt;
 
-	const char *short_opts = "C:K:P:O:A:Sh";
+	const char *short_opts = "C:K:P:O:D:A:Sh";
 
 	static const struct option long_opts[] = {
 		{"cert", required_argument, 0, 'C'},
@@ -332,6 +332,9 @@ int main(int argc, char **argv)
 			}
 			hashes[hash_count++].file = optarg;
 			break;
+		case 'h':
+			usage(argv[0]);
+			return EXIT_SUCCESS;
 		default:
 			usage(argv[0]);
 			return EXIT_FAILURE;
-- 
2.53.0

