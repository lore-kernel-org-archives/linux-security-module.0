Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D703281732
	for <linux-security-module@vger.kernel.org>; Thu, 28 May 2026 03:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779937784; cv=none; b=rCCQkQuOAFm8iDsOjGArsWOiJkYVOYRMj4BdYMvv+3R0LN3zWmnDk4moKwmkG/51b6nXK7AW/uD4f54nuankAcDMY3WYf2i7H62+TxRCSHQeVLMjNpElq1bGZ4QBoxUhTCqMFZ9Pp5IdtW45ySNIAJZp9BGm2l+Au36XNsj2qqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779937784; c=relaxed/simple;
	bh=7Of3nTf+w6zZvHOYxT9OMIo8CYwym0mpR86pmhuhUuY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rs9WJg+uKkM7s6gmHz5L5W2VKj+eI3YeM6a8mg45KGGG3Vki7KCLMiWXTnXv4LQeQLh60oxQvPTZHiV40cAML+RWXIIqK58TUn6eIQSkO1GmW6gqueDCVU0UXK7KR3MHiB4/O3azkg0oBYLCc0GFzKapQfgu46fSJEZFVQsotqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=qoQ7DrGJ; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="qoQ7DrGJ"
Received: from narnia.corp.microsoft.com (unknown [40.78.13.147])
	by linux.microsoft.com (Postfix) with ESMTPSA id 73F0F20B7169;
	Wed, 27 May 2026 20:09:31 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 73F0F20B7169
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1779937772;
	bh=JT25VAKSQJYaGDEh1PrXrU9wRLbeDN9hJiTcijls/kw=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=qoQ7DrGJD0efVZIVTsLmY5ZmJIw3gRZMBoa6Xzzi2o4zwbhOVM7cOPmZjHHCXKt4Y
	 yQRpNM3xxrLRlgA/nMJi649WC34/yg/hR8VBhqbWs3ybJ768tzu9ruhsmjWhP2iimC
	 JUfbD6uv9VhFVuCRyEVODfW8yvZHYO75iEZn9HYw=
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
Subject: [PATCH 05/11] hornet: gen_sig: fix off-by-one check for used maps
Date: Wed, 27 May 2026 20:08:14 -0700
Message-ID: <20260528030915.2654994-6-bboscaccy@linux.microsoft.com>
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

A logic bug limited the maximum number of used maps to
MAX_USED_MAPS-1.

Signed-off-by: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
---
 scripts/hornet/gen_sig.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/hornet/gen_sig.c b/scripts/hornet/gen_sig.c
index b4f983ab24bcd..4e8caad22f381 100644
--- a/scripts/hornet/gen_sig.c
+++ b/scripts/hornet/gen_sig.c
@@ -317,11 +317,11 @@ int main(int argc, char **argv)
 			data_path = optarg;
 			break;
 		case 'A':
-			hashes[hash_count].file = optarg;
-			if (++hash_count >= MAX_HASHES) {
+			if (hash_count >= MAX_HASHES) {
 				usage(argv[0]);
 				return EXIT_FAILURE;
 			}
+			hashes[hash_count++].file = optarg;
 			break;
 		default:
 			usage(argv[0]);
-- 
2.53.0

