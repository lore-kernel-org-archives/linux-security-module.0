Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1811C4A3E
	for <linux-security-module@vger.kernel.org>; Sun,  6 Jul 2025 15:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751815080; cv=none; b=NMpa0gMJcGnVoZJhxhU6WmjyDN6GZLVAvonU4jLeCKFwJhJKmMOvWGi1iXtvZw1BzqvcAkD/dvE92k5gvsFZb5mLWov66Izwo0tN2Do/yHSXekLcschQk9Vka78slE9kZwdXG5ZBvFpjSFxWmmIgby/BfPeIWdX33aOekUxJ89c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751815080; c=relaxed/simple;
	bh=ud5LXhfT+lkSpbl4u9yWtkqKlFZboJWm0eXDUb7S4vY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GvQpCMffA5+KtQV10/2gytkfLd6KACQ2y3zy6f/AqARBWDea34hCB6XI8xZkcB2MPP3HZITSczD/zLBDDFfaagQDNIXKprhBqeGalPukKS9HJjpiC4p5i1WetmYqA4iGrteS8nXeI3+6OdQ7me4SPbSuLjMenB2qD+bc0mx9Dro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=X4QD95UQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=P8SqBf//; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="X4QD95UQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="P8SqBf//"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id EF2811D000E7;
	Sun,  6 Jul 2025 11:17:56 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Sun, 06 Jul 2025 11:17:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm2; t=1751815076; x=1751901476; bh=lg
	xxXufJYMY1nNMc9qZC04Bqz2mDJjdmY3g5JadvMms=; b=X4QD95UQomW6A5dBp/
	HWB7X54gx9klKpZuXq75OR+DJ0QmaWOYqmZuvj8ihjtTnOE6bgE3GcjgGEY+qI7O
	8v0K0htiO1KTm9vThbTcADvvVk+vRuKNnu2y56E9DgG8Ikku2P4ZHCnU9glU2Ra+
	sSA3ERJxipzOWWaLKkbB9ohGYk92Vt2BJUMSkmqSiJv4eYMnbia9axTOLshp5L4+
	+N0lmo53Lb92B662XMmuSLll01n7XgPLVv9nvf+T5qRnrr5A2mYC3qSaIKkIamcO
	Tkt94KC+au9knUn7t7o7C7b9hNYDKNJQQ2lURpI5/fVLcyFSW8B0LZCdPrn5geC7
	GFnA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1751815076; x=1751901476; bh=lgxxXufJYMY1nNMc9qZC04Bqz2mD
	JjdmY3g5JadvMms=; b=P8SqBf//KwVjOiBkGxwx9u4aZv49jrrHhJgjL7MXH7tg
	385OWrb/Qk5JgQUzy0eWZEu1j56FwK5VC7XzVG4QRv4ivocpNhOXisF4+lY89SD4
	/A2yaQZXAvkEHWm25FHwLNqnT2EvYFxc7Qyw2ufeDztssanDYBGXu9bgZdj+SJXy
	SWbTyyIZbhnMCeNSI4ljr5qLjr1ulVHowsgmqz+PVu0Z1AG6EVY8m7GkXDfwLwif
	Iyl+SBGUvnjUlYOmDRvvtBn3F831e8rWYyE5iuFNKIvaiPhc/edwDnGJeBZQyNs1
	4BL0Tk5ozY2dbQVym/KArTcBMaF8JOW/2myiIEtnKA==
X-ME-Sender: <xms:o5NqaKLQTCzFFGMm7TdL-yMiHfwKtz00qeKYD4uM3dwYmU2FM20jOg>
    <xme:o5NqaCJ9dPlUXruaRsCFfJ24R03-OT6PW2Qtc8TDCwmz7zqTSIBXelRb1ideagEYT
    XFIoEvVMQuXscte0JQ>
X-ME-Received: <xmr:o5NqaKsrvq2m7QhmWoQqVNbbg-VU_Ozyxc-3KLPbYsKFes8kmnD_N8XpyD3X4OBKmZm9SR05puOusjH-2AoNOoL3Kbjz6kMJNwlnr8ZYcSLiP_MqKVVc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddvledvhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffogggtgfesthekredtredtjeenucfhrhhomhepvfhinhhgmhgrohcu
    hggrnhhguceomhesmhgrohifthhmrdhorhhgqeenucggtffrrghtthgvrhhnpeetteeute
    eklefftefhvedvgfdtvdehleehudfhfffgvddtiedvtedvtdelgfefjeenucffohhmrghi
    nhepmhgrohifthhmrdhorhhgpdhkvghrnhgvlhdrohhrghdpghhithhhuhgsrdgtohhmne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhesmhgr
    ohifthhmrdhorhhgpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprh
    gtphhtthhopehmihgtseguihhgihhkohgurdhnvghtpdhrtghpthhtohepghhnohgrtghk
    sehgohhoghhlvgdrtghomhdprhgtphhtthhopehmsehmrghofihtmhdrohhrghdprhgtph
    htthhopehlihhnuhigqdhsvggtuhhrihhthidqmhhoughulhgvsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepihhvrghnohhvrdhmihhkhhgrihhludeshhhurgifvg
    hiqdhprghrthhnvghrshdrtghomhdprhgtphhtthhopehjrghnnhhhsehgohhoghhlvgdr
    tghomh
X-ME-Proxy: <xmx:o5NqaPalu6VHpkXPCauW-uHweHN9mVbXy11E8RLvvyfzFt9Qn3sk0g>
    <xmx:o5NqaBZyDLf5jVJ0pKwCBRm2bYFPJj9idJgI7o8ooNzHt9DGrK3gPQ>
    <xmx:o5NqaLDz-t-ioPpRFwVYWT6XSfn8SfEFw_C-swW7AmDM3BihiIxn6A>
    <xmx:o5NqaHZzp41qalVNEpucnzbAAmlJ4YiT75-rAElMwdcEnoQrB-CMzw>
    <xmx:pJNqaLjPYnSDwCzGq7F1HiRRbsV_qW76peEQHlG91c19BZ21koCFnXIX>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 6 Jul 2025 11:17:54 -0400 (EDT)
From: Tingmao Wang <m@maowtm.org>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>
Cc: Tingmao Wang <m@maowtm.org>,
	linux-security-module@vger.kernel.org,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	Jann Horn <jannh@google.com>
Subject: [RFC PATCH v2 00/12] landlock: Use coalesced hashtable for merged domains
Date: Sun,  6 Jul 2025 16:16:41 +0100
Message-ID: <cover.1751814658.git.m@maowtm.org>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

This implements the proposed data structure from the last discussion on
hashtable domains [1], in which we store all the rules and layers of a
domain in one flat array.  But instead of doing binary search, we use a
hashtable lookup, which has performance benefits.  The goal here is both
to improve performance and also reduce Landlock's memory footprint as much
as we reasonably can.


struct landlock_domain
----------------------

This patch set creates entirely new structs to use for a merged domain,
instead of using landlock_ruleset and landlock_rule (although we still use
landlock_layer).

Since we are no longer allocating individual struct landlock_rule for each
rule, and also because this representation is more compact and does not
use any rbtree pointers, this should reduce the memory usage for a merged
domain.  In the current implementation, even if each rule only has one
layer, the struct landlock_rule would effectively take up 64 bytes due to
kalloc placing it in the next power-of-2 bucket.

While this is not completely done in this series yet, the hope is that we
can remove all code that deals with the old landlock_ruleset domain, and
simplify the landlock_ruleset and landlock_rule struct since they now only
need to represent an unmerged ruleset, which will only contain one layer.
This series already removes some existing ruleset merging code.


Hashtable implementation
------------------------

This patch set implements a "coalesced hashtable", which uses an array
instead of linked lists, and uses the array itself to store collisions, by
storing them in "unused" slots (since the existence of collisions
necessarily mean that some hashes are not used).  A more detailed
explanation of this algorithm is included in the commit message for patch
2 and 5.

The hashtable we've implemented here is a immutable-after-construction
table (technically one could probably still append to it with some care,
but in principle it should be construct-once), which fits the use case for
landlock - merge a domain once, then we just need fast read-only query.

Some research has not led me to finding any existing implementation of
such a coalesced hashtable in the kernel, therefore this series introduces
new code for this algorithm.  Currently it's placed within
security/landlock, but it is written in a generic way that if somebody
else wants to use it (for example, current users of binary search on a
fixed array?), they can probably do so relatively easily (aside from
needing to move this header outside of landlock).

Testing
-------

All selftests pass under UML.

I plan to implement Kunit tests for the hashtable (and maybe also the
domain) in the next version.


Benchmark overview
------------------

I ran benchmark with before/after using two workloads, on the same machine
and setup:

    1. run_microbench with different depth and number of extra rules using
    code in [2]

    2. A more "typical" workload I put together quickly, with 18
    reasonably logical rules, calling git status and the like repeatedly
    [3].
    (I've consistently used this same workload for benchmarking previous
    performance improvements patches, to reduce the chances of accidental
    cherry-picking)

Results for the "typical" workload

Comparing:                    before    after
  landlock_overhead:    avg = 34        34
                     median = 35        34          (-1)
  landlock_hook:        avg = 878       856   (ns)  (-2.5%)
                     median = 854       831   (ns)  (-2.7%)
  open_syscall:         avg = 2517      2485  (ns)  (-1.3%)
                     median = 2457      2425  (ns)  (-1.3%)

Results for a 100 rules test with 10 dirs to walk upwards:

with landlock: d = /1/2/3/4/5/6/7/8/9/ nb_extra_rules = 100:
  landlock_overhead:    avg = 15     15
                     median = 17     16          (-1)
  landlock_hook:        avg = 832    785   (ns)  (-5.6%)
                     median = 826    776   (ns)  (-6.1%)
  open_syscall:         avg = 5163   5001  (ns)  (-3.1%)
                     median = 4763   4847  (ns)  (+1.8%)

Note that the 100 rules benchmark has quite variable performance, and the
testing method probably meant that most of the time is spent in VFS
lookup.  (Mickaël has gave some suggestions for improvement which I've yet
to do)

The full results and .config used (basically Debian) can be found at
https://fileshare.maowtm.org/landlock/20250706/index.html


Outstanding TODOs
-----------------

- selftests for the coalesced hash table, and maybe also for the domain
- simplify struct landlock_ruleset and struct landlock_rule since they now
  only need to deal with one layer,
- Using the name "layer" to refer to individual struct landlock_layers is
  very confusing especially with names like num_layers - the next version
  should probably find a better name for it.


[1]: https://lore.kernel.org/all/20250526.quec3Dohsheu@digikod.net/
[2]: https://github.com/landlock-lsm/landlock-test-tools/pull/17
[3]: https://github.com/micromaomao/linux-dev/commit/f1865ce970af97ac3b6f4edf580529b8cdc66371

Patch based on mic/next (v6.16-rc2+)

Closes: https://github.com/landlock-lsm/linux/issues/1

Changes since v1:
- Entirely replaced the hlist-based hashtable with an array-based one.
- This time added support for net rules too.

v1: https://lore.kernel.org/all/cover.1747836146.git.m@maowtm.org/

Tingmao Wang (12):
  landlock: Set the max rules limit in a domain to U16_MAX.
  landlock/domain: Define structure and macros for flat-array domains
  landlock: Define coalesced hashtable and implement finding
  landlock/domain: Implement finding rules
  landlock/coalesced_hash: Implement insert
  landlock/domain: Implement merging of a parent domain and a ruleset
  landlock/domain: Define alloc and free
  landlock/domain: Add landlock_domain_merge_ruleset
  landlock: Update various code to use landlock_domain
  landlock: Remove unused code
  landlock/task: Fix incorrect BUILD_BUG_ON() in domain_is_scoped
  landlock: Use a hash function that does not involve division

 security/landlock/audit.c          |   8 +-
 security/landlock/coalesced_hash.h | 399 +++++++++++++++++
 security/landlock/cred.c           |  12 +-
 security/landlock/cred.h           |  14 +-
 security/landlock/domain.c         | 681 +++++++++++++++++++++++++++++
 security/landlock/domain.h         | 342 ++++++++++++++-
 security/landlock/fs.c             |  34 +-
 security/landlock/limits.h         |   2 +-
 security/landlock/net.c            |  12 +-
 security/landlock/ruleset.c        | 319 +-------------
 security/landlock/ruleset.h        |  71 +--
 security/landlock/syscalls.c       |   8 +-
 security/landlock/task.c           |  31 +-
 13 files changed, 1499 insertions(+), 434 deletions(-)
 create mode 100644 security/landlock/coalesced_hash.h


base-commit: 86fdfbade8bb09ce2be2ff334c743fe19815ceb2
-- 
2.49.0
