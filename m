Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793621747;
	b=b81WoAA9FwpHMFASszqBOcdBN7mvrbLUg8hLuJJJTxFVdzMFioM3qCgautXlu240vxv4
	 HKCsgjifyVCMuDCRHAysX6yHTGMNLGTt1KUcTQVd2SKK8mFV0W9Pugxi+y4DY/4nbL0w2
	 ICL/2/FjjXYQG5kCjkB+fPs7irnd50uFOH1dOEq87+Mst7YMG4kbD4ANCnThSGZufRZjq
	 kjIwJNjkRnB8BuQRPl4+rxlnsCalK09LhSN2XxrrSOADimfY56vO0Y8XHBvcMR+6sknmX
	 d7i3eGC918qpnlN23l9FlMYaGAQ7ppJvZ7zE3knqFIVxuNz9oUc4Nv8v0mqjM5J75Ag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793621747;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=1fTN69QAXrwVYTqaRarUN9MUASWr/+dvtqMQWNVlarU=;
	b=kRVvoMPp/iaXbnvRjQ8YMfXtr0VP2GhxrkCF5OsV9y9BK2pJOmr23plRf4nrEDqgzARh
	 m3vXSQ8to/yXkk3YF1+xOpico/3Lar1S43PirU5R9OHm5YSPczbPCK36fY2v2/74o1RcS
	 0akG6aa6R/L/b0a4a4hPw5HqTBLWEAv3KCLluzwVjttrqzDBYmSGbgWJBHx6FZav2/Il8
	 0JDa0IJnrNcqLR9gPtbFev4FeL1m+ooJ+07SUyUFcs5UOpEmJcmvSVkdVkSfHWD2Qe0zG
	 xXmoPk3mqodV7RBjD2Ctz7pGEM8cmocTdUH+4cMWXr5ZiDjL6L6g29/vackSZImvJlw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lArypeeC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 5C3BD60A260E;
	Mon,  2 Nov 2026 12:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lArypeeC
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 6D2801F00A26;
	Mon,  2 Nov 2026 12:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793621747;
	bh=1fTN69QAXrwVYTqaRarUN9MUASWr/+dvtqMQWNVlarU=;
	h=From:To:Cc:Subject:Date;
	b=lArypeeCOSeIY4XN3qAoPMF7VYYBYM6D43BzO5IEZs/L7KzDOaaXkcmef6XIvZPgC
	 5RlKTXtHkvzwqcjKasCCv/9KDx+cRZqqhaasERCwuMeXugK6gJgTL2AhLdMn7sySCO
	 6rBfvk65PoUoLPOJQSKRnjf5l/4qNWQi3gNaqOPIApC7+Lag4slsQopI/1g+FwCf0H
	 lJv8KwwGuUUd+LXWApACnWUOc8am2OEZgUVWHw9Mcb8xs810ACnE30K7npXBVtP2Ce
	 D5eoKkyhin/09jlqMhL3dRhJmobxuZHsrmi791E+WgDyJc1sJpVJziAAPKSjkzTbrn
	 CLY3r0xSXLtqA==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Eric Biggers <ebiggers@kernel.org>,
	linux-integrity@vger.kernel.org,
	Mimi Zohar <zohar@linux.ibm.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-security-module@vger.kernel.org (open list:SECURITY SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list)
Subject: [RFC PATCH 0/4] KEYS: sanitize the garbage collector behavior
Date: Mon,  2 Nov 2026 14:15:11 +0200
Message-ID: <20261102121518.1197453-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.47.3
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

1. Remove key_type_dead and replace it with the regular module semantics.
2. Replace variable size workqueue items with fixed-size 64 key chunks.

The first change has user space visible effect: rmmod semantics will change
from always succeeding into returning -EBUSY when keys or restrictions have
the LKM pinned.

Jarkko Sakkinen (4):
  KEYS: trusted: Disable sysfs bind attributes for TEE driver
  KEYS: Pin the backing module for struct key_type
  KEYS: Remove key_type_dead
  KEYS: key_garbage_collector(): process in chunks

 include/linux/key-type.h                 |   6 +-
 security/keys/gc.c                       | 249 ++++++++---------------
 security/keys/internal.h                 |   7 +-
 security/keys/key.c                      |  46 +++--
 security/keys/keyring.c                  |  84 +++-----
 security/keys/trusted-keys/trusted_tee.c |   1 +
 6 files changed, 148 insertions(+), 245 deletions(-)

--
2.47.3

