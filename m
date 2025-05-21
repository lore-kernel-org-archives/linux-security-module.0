Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E888622F15E
	for <linux-security-module@vger.kernel.org>; Wed, 21 May 2025 19:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747856087; cv=none; b=CwfLKx1Udw3jCxxWv2JJIMQfSBLyDUPmZoV/tmFt0WWOEjF2cqIHwjO1fbG4cT5utIwyOn7vIMaMAH0BmtjFecGbPZ63F2G9F8ygxxBAg2ImlNQFk1RTBHqTi/L0jOaElECNuZZFvD6rjod8OdChuZiotqemnW5CSVRNydn5gmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747856087; c=relaxed/simple;
	bh=MsDQzfrIQt+yd7rdf/YZJ01BM83y+cEJLdT/lGC4eos=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ARJE+K6o44GCGT4jRp869ri3Hs5VxegZylA2MohTsn1WM6wo3TsZ1VO9OWut0iGSelGuA+2PzrHSAaHgYYEuQm7wbxtS2mWYNMc1jxwVA2w/MzFTogzTHxJ/IwhgQ88Wddg2iAOg2vBmzzPeSBs33eTakKXWOc+iJObewL6nhF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=cR0Gv6YY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=g4XRJYkC; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="cR0Gv6YY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="g4XRJYkC"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 0BFB01380190;
	Wed, 21 May 2025 15:34:43 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 21 May 2025 15:34:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm3; t=1747856083; x=1747942483; bh=WP
	QJdCxNk6FAHopRPJwO1kn1ONTxWnHTXU8L8rTZq98=; b=cR0Gv6YYEHnW9lOsh0
	rAZXwbxVqmI0lrI2oqtH3pfTSIVL2XYShRVBrVWmzRQOjNwS/CZnLdzDisjVwb11
	s0YepDGO7CyBYvlwgydUaFiUSIgfq/A5Q/1H5JmLKIzaXdPGr/EoFETn5sH4/tmx
	v4/ffwvKBMH2t9KlqrCnef3Nw7wyTJmBwoOctOlHllvg70Mmo+FLIiyrE0rm4lEO
	5O5X9BrwhGxzkCxsYqXc3W8kTp9pY2pjVxpXJ/auOQb1GnaQVmnJr8PsZpA4F5Bx
	5wvsAD7/Bsp0YxbUJIt80jnRMkNg+OHWs1h+LlQaXPwDnRQEvu5AE6vg0awXl3Dc
	s8Zg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1747856083; x=1747942483; bh=WPQJdCxNk6FAHopRPJwO1kn1ONTx
	WnHTXU8L8rTZq98=; b=g4XRJYkCA/pDiOrx+pBvdpN1EVFUEf7iX07Y/aRlXB5p
	6S7K4ZvZTKp12/Ibw5dGMDUtFplmzwPhCb5jCdit3bIpTgG5vQonvhCwrXLAciqI
	xYjHd9N12+jqTMbi2rUJTX2xUs7IkU3F2RS5tYqqtYVuIbLSzhP+bboJgxFDdK1F
	mc1AsnJaouN2asOEfxarODyTDJPYtzBp4zsATUw8Fr0ZoOBDdC5psV26UNliEiQz
	qFZnl2GOTqc50/tt8mBTPriKlMGu26Ji56Tjy0AcH1kOt7LKfap6O9zTF8aTNI/I
	htgUkIEK0IDXWMakkoePsQgKRrVrcCtdl+qTjINphQ==
X-ME-Sender: <xms:0iouaFV1rNVMDkuEBscoelU4DohjiwjRNSNK7zyAF_9wAuMp6aBp5A>
    <xme:0iouaFlvKhTLjoiYWorPKsWT4QJWnBoM2Q32TRUrmjftxKPBywfnNtwJViz2xJdwZ
    VkMezH3xbWOs7iaQys>
X-ME-Received: <xmr:0iouaBa3h4GSoTSxiOhlImxS5-cqU0m7rGbMzXb9rYwcMa87igJTVT_lJpPTPGrDEipSJUdZ4zh2w7BbDH85yK1C4gnOZHUQcJZK_qzO8ZOVFC3InaR_Cg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdefleegucdltddurdegfedvrddttd
    dmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgf
    nhhsuhgsshgtrhhisggvpdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttd
    enucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgg
    tgfgsehtkeertdertdejnecuhfhrohhmpefvihhnghhmrghoucghrghnghcuoehmsehmrg
    hofihtmhdrohhrgheqnecuggftrfgrthhtvghrnhepffduheduvdeuvdfhiefhvdetieet
    keelueehheeigfduveeggfevleetuefhjeffnecuffhomhgrihhnpehgihhthhhusgdrtg
    homhdpmhgrohifthhmrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepmhesmhgrohifthhmrdhorhhgpdhnsggprhgtphhtthhopeegpd
    hmohguvgepshhmthhpohhuthdprhgtphhtthhopehmihgtseguihhgihhkohgurdhnvght
    pdhrtghpthhtohepmhesmhgrohifthhmrdhorhhgpdhrtghpthhtohepghhnohgrtghkse
    hgohhoghhlvgdrtghomhdprhgtphhtthhopehlihhnuhigqdhsvggtuhhrihhthidqmhho
    ughulhgvsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:0iouaIUkcjZgC9acFd8_kc7nHMSrarPF1znY9OMzJL2Y64RKANVPWA>
    <xmx:0iouaPnOSPgfBE3YHuKTDtNYrziF04VffabtBTakjCC9ApQyHR2spQ>
    <xmx:0iouaFdyZl016pIsMuyj2ESKoZSmFIHb5mXH_3yXG2J6rw57MGJLAg>
    <xmx:0iouaJFqKhztVpbaZM6nLkGx_frlV9qfGDJ6yyCVofJEDwhLP8QMuQ>
    <xmx:0youaCmW_gCs9y-njkJpPiO-Owo8yTxaQCtVx5QsILSSso4obxbqc1f3>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 May 2025 15:34:42 -0400 (EDT)
From: Tingmao Wang <m@maowtm.org>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Tingmao Wang <m@maowtm.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	linux-security-module@vger.kernel.org
Subject: landlock: Use hashtable for merged domains
Date: Wed, 21 May 2025 20:31:56 +0100
Message-ID: <cover.1747836146.git.m@maowtm.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Mickaël,

This is a set of (incomplete) patches for the "domain hashtable" work.
While this is still a WIP, I'm sending it now as per our discussion.  You
can take a look and see if the approach needs correcting / if we want to
go ahead with using hashtable.

Currently only implemented for fs access.

This set of changes is also available on the landlock-hashmap branch of
https://github.com/micromaomao/linux-dev.git


struct landlock_domain
----------------------

One of the major thing I'm not sure about in this patch is the fact that
I've decided to create a standalone `struct landlock_domain`, instead of
re-using landlock_ruleset.  My original hope was that it might help make
the code a bit clearer - struct landlock_ruleset would just be for
unmerged rulesets (and it can use rbtree if we still wants to), and we can
use this new type for domains (and add new fields and locks to it that
wouldn't be on a ruleset, for the mutable domains / supervisor work).

I also wanted to split the logic of dealing with rules in a merged domain
(hence needing to copy multiple layers etc) out of create_rule and
insert_rule, and simply these functions (especially insert_rule) by
letting them just deal with unmerged rulesets (so only one layer) - the
logic for merged domains would be different anyway since it's no longer a
rbtree walk (but something like landlock_hash_upsert in patch 8 instead).

However, looking back at it, I'm not sure if creating this landlock_domain
was actually a good idea.  Going down this route eventually I will just
have to move all the domain-related logic from using ruleset to using
landlock_domain.  If we decide to use hashtable for unmerged rulesets too
(not done in this patch, and need more thoughts on how that would work),
then separating this out is even less value.

Regardless, the relevant code in this patch should still be easily
portable to just extend landlock_ruleset with hashtables, so I'm happy to
do that instead in the next version.


Hashtable implementation
------------------------

Since I couldn't find a suitable existing wrapper for runtime-sized (but
fixed after creation) hashtables, this patch uses a newly hand-rolled
implementation.  It's not very complex so this might be fine, but there is
also rhashtable which would be especially suitable if we want to use hash
table for unmerged rulesets too.  See patch 2 message for details.


Testing
-------

selftests/landlock/fs_tests all passes under KASAN, lockdep etc.  Other
tests showed no obvious issues, but base and net fails due to missing
config (no MPTCP, no CONFIG_ASYMMETRIC_KEY_TYPE i.e. keyctl)

I ran benchmark with before/after using two workloads, on the same machine
and setup:

    1. run_microbench with different depth and number of extra rules using
    code in https://github.com/landlock-lsm/landlock-test-tools/pull/17

    2. A more "typical" workload I put together quickly, calling git status
    and the like repeatedly:
    https://github.com/torvalds/linux/commit/f1865ce970af97ac3b6f4edf580529b8cdc66371

On the "typical" workload, which has 2 layers and ~15 rules, we have:

Comparing:                    orig	  hashtable  (% change)
  landlock_overhead:
    (this is the % of time spent in landlock hook in the open syscall)
                        avg = 34      33         (-2.9%)
                     median = 34      33         (-2.9%)

  landlock_hook:        avg = 837     775        (-7.4%) (unit: ns)
                     median = 813     748        (-8.0%) (unit: ns)

  open_syscall:         avg = 2429    2324       (-4.3%) (unit: ns)
                     median = 2370    2265       (-4.4%) (unit: ns)

Using the microbench script, for an extreme case on a path beneath 28
directories and with 10000 rules:

Comparing:                    orig	  hashtable  (% change)
  landlock_overhead:    avg = 27      24         (-11.1%)
                     median = 29      25         (-13.8%)
  landlock_hook:        avg = 1913    1577       (-17.6%)
                     median = 1884    1544       (-18.0%)
  open_syscall:         avg = 6775    6259       (-7.6%)
                     median = 6666    6115       (-8.3%)

The full results can be found at
https://fileshare.maowtm.org/landlock/20250521/index.html

Closes: https://github.com/landlock-lsm/linux/issues/1

Tingmao Wang (10):
  landlock: Add some debug output
  landlock/hash: define (dynamic, non-resizable) hash table helpers
  landlock/hash: Use linear search for small tables
  landlock/ruleset: Rename and extract create_rule
  Add hlist_node member to struct landlock_rule
  landlock/domain: Define landlock_domain
  landlock: Add the new domain to landlock_cred_security
  landlock: Construct the inode hashtable in the new landlock_domain
  landlock/fs: Use the new hashtable-based domain to find inode rules
  landlock: Debug print inode hashtable in landlock_merge_ruleset2

 security/landlock/cred.c     |   8 +-
 security/landlock/cred.h     |   1 +
 security/landlock/domain.c   | 145 +++++++++++++++++
 security/landlock/domain.h   |  45 ++++++
 security/landlock/fs.c       | 107 +++++++++----
 security/landlock/fs.h       |   1 +
 security/landlock/hash.h     | 294 +++++++++++++++++++++++++++++++++++
 security/landlock/ruleset.c  |  80 +---------
 security/landlock/ruleset.h  |  99 +++++++++++-
 security/landlock/syscalls.c |  35 +++++
 10 files changed, 702 insertions(+), 113 deletions(-)
 create mode 100644 security/landlock/hash.h


base-commit: 3039ed432745f8fdf5cbb43fdc60b2e1aad624c1
--
2.49.0
