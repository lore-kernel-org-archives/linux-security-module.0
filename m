Received: from flow-a3-smtp.messagingengine.com (flow-a3-smtp.messagingengine.com [103.168.172.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E177C1CCB21;
	Thu, 27 Mar 2025 21:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743111506; cv=none; b=YnK+UtQ4M+JnlI1d4VzZ4vwGJxkXhUHHjdHayerjSW066w/tL4RFOBpA8vCMPDHRZZaDFuVAwEyaDNbEQX4kVKF6uJXw8LAOOF64RSVcZ4Rz2/ysQsjVQpMC4ZPdJky5SyXUNMJ7FeXs641aiRunH9dcq96m+5qYPLL7AUcsMx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743111506; c=relaxed/simple;
	bh=qEEsWxmDu2SraV5a65CHrYEKOhjSn8vVjEBpRvl/OAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iVoyVlAs935NL6+BDwDHUzt7VQwN8/JowKrnPBUKtw0T5rf1IgQihX0dhal1K3cJeM6qd+rT/jv0/x1bZc8+/yaNe9dqkSL9BjqVOH5FXU47NNqBUgpAz5EkMuczhmn7BkkkXv/d/DUziu2Nug+2d5Ssp0kgoAfxnE/Dm6cpVWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=RoYqd2hM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mBa1uEfO; arc=none smtp.client-ip=103.168.172.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="RoYqd2hM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mBa1uEfO"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailflow.phl.internal (Postfix) with ESMTP id D99FA201E89;
	Thu, 27 Mar 2025 17:38:22 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 27 Mar 2025 17:38:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1743111502;
	 x=1743115102; bh=Rsm2ZPE2+P/FMcLCyzyCdEQTiLTQl/3wdDa8zkMU5Ho=; b=
	RoYqd2hMS9LXXbA4vV7EExpWAiGP8M1JlAfUyhctgTpuijC0wKoSCcjl5F/c+w2t
	IDZNmVcOS82pqzNYqdsN9oe4wQan5ptjeTYcDfp+ZcDvFNtphif4hxgCQ9FrlkoS
	izBl5AtOEDLb9GyxD1vuGKnyag2nj0nyZM0eNyFuw4CMywZ8nb0VZGLAuX7D4AlE
	bJ44zlNOJGSVqmPwmRbgjubTDXdoIY4/RTucK6LbUM6mk0YM1uxsQtqdI5yv9Y6z
	nxwYM9ljGHIepwtIffVkMDEPsv7toO/gwQoFYUzqLOzsBsn2qZ+7/UrC6oB5OoLl
	nFJ0w+Q2oHImJZ6iDleRPw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1743111502; x=
	1743115102; bh=Rsm2ZPE2+P/FMcLCyzyCdEQTiLTQl/3wdDa8zkMU5Ho=; b=m
	Ba1uEfOq7f23NGqW+MED+U9Qu651tolg89tM7iZCdd5LP2pE9Mxzd9xRUQ5nisLx
	VXXlm4XvvJEQXepNjsO8J6hsRq2D4O1CSDtj+8WOrM8uPEBswwLpSEdVBcxhcBCG
	59LxTGBBz7kmVD/1RmOzF5wkJMX8ABXUJ5nSgSez31miA+ICilZd44vkROpi/3zE
	H1oH6s5rjpaXeCKK9OKCGsFAv5lz+1xa3u1/5Aohm2wdCztH+J8aX2w1weMebLwx
	PmXqCNn1DU7sSXLqsYlKHB32eFZEZFjMROZSOnxBdhwdielqYfPHYRiASQNiJPSh
	MplSdZmw+mPn5H+dI/wnw==
X-ME-Sender: <xms:TsXlZ7blf9qKtsZ0qaJIke1IfjjzphRfmmApT86nXZl3egPpNRD4xA>
    <xme:TsXlZ6ZulNBN6HqMqdRVg9Zaft4CeJsGYo6Ls-z1q_3KmqskwicS1UYxM3zw4OBYE
    pbLV0_gBbpa010ExJw>
X-ME-Received: <xmr:TsXlZ9-YBBf-L0j1-M-245-IvsF8hfF3BllgjUBndy87kTEKR0zHYSJbW9wiONW9dwd4xDcm6Qtihcv5EM0wLl0HUig>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduieelheduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvf
    evufffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepvfhinhhgmhgrohcuhggr
    nhhguceomhesmhgrohifthhmrdhorhhgqeenucggtffrrghtthgvrhhnpeeiieeggeehtd
    ffieffhfekueffhefhveeugfdvkeejkeehvdettdfgvdeghfdujeenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmsehmrghofihtmhdrohhrgh
    dpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhhi
    tgesughighhikhhougdrnhgvthdprhgtphhtthhopegruhguihhtsehvghgvrhdrkhgvrh
    hnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqshgvtghurhhithihqdhmohguuh
    hlvgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehmsehmrghofihtmhdr
    ohhrgh
X-ME-Proxy: <xmx:TsXlZxrdxIInc7Y2-VThr2tOUTNGfZ6NdznP1_JLGBkmOu7dcoiukg>
    <xmx:TsXlZ2pEsyh5Ua1F3b5MxSNwNCY9PXhl09yzgx1fpDQgDd5WtabHhA>
    <xmx:TsXlZ3T5aeKVqf3jO6cfu4Ml0SI7YSAE-xN5POaL3yKM1bAbLkJhGg>
    <xmx:TsXlZ-r_yp65imzZy78-unSSpRQMnPjs0lJBL-AjJmxxPPDCgoNYgQ>
    <xmx:TsXlZ920tgx76ZXg11LmT6pG7m1KZpfRy-_l6EADZa0ZWfjvgL_wtaG5>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 27 Mar 2025 17:38:21 -0400 (EDT)
From: Tingmao Wang <m@maowtm.org>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: audit@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH v7 09/28] landlock: Add AUDIT_LANDLOCK_ACCESS and log ptrace denials
Date: Thu, 27 Mar 2025 21:38:05 +0000
Message-ID: <20250327213807.12964-1-m@maowtm.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250320190717.2287696-10-mic@digikod.net>
References: <20250320190717.2287696-10-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Mickaël,

On 3/20/25 19:06, Mickaël Salaün wrote:
[...]
> +static struct landlock_hierarchy *
> +get_hierarchy(const struct landlock_ruleset *const domain, const size_t layer)
> +{
> +	struct landlock_hierarchy *hierarchy = domain->hierarchy;
> +	ssize_t i;
> +
> +	if (WARN_ON_ONCE(layer >= domain->num_layers))
> +		return hierarchy;
> +
> +	for (i = domain->num_layers - 1; i > layer; i--) {
> +		if (WARN_ON_ONCE(!hierarchy->parent))
> +			break;
> +
> +		hierarchy = hierarchy->parent;
> +	}
> +
> +	return hierarchy;
> +}
> +
> +#ifdef CONFIG_SECURITY_LANDLOCK_KUNIT_TEST
> +
> +static void test_get_hierarchy(struct kunit *const test)
> +{
> +	struct landlock_hierarchy dom0_hierarchy = {
> +		.id = 10,
> +	};
> +	struct landlock_hierarchy dom1_hierarchy = {
> +		.parent = &dom0_hierarchy,
> +		.id = 20,
> +	};
> +	struct landlock_hierarchy dom2_hierarchy = {
> +		.parent = &dom1_hierarchy,
> +		.id = 30,
> +	};
> +	struct landlock_ruleset dom2 = {
> +		.hierarchy = &dom2_hierarchy,
> +		.num_layers = 3,
> +	};
> +
> +	KUNIT_EXPECT_EQ(test, 10, get_hierarchy(&dom2, 0)->id);
> +	KUNIT_EXPECT_EQ(test, 20, get_hierarchy(&dom2, 1)->id);
> +	KUNIT_EXPECT_EQ(test, 30, get_hierarchy(&dom2, 2)->id);
> +	KUNIT_EXPECT_EQ(test, 30, get_hierarhy(&dom2, -1)->id);

This causes a warning from WARN_ON_ONCE(layer >= domain->num_layers)
when running this test, I guess because layer is unsigned.  Should it
be ssize_t, if this is an expected usage?

------------[ cut here ]------------
WARNING: CPU: 7 PID: 145 at security/landlock/audit.c:142 get_hierarchy (security/landlock/audit.c:142)
Modules linked in:
CPU: 7 UID: 0 PID: 145 Comm: kunit_try_catch Tainted: G                 N  6.14.0-next-20250326-dev-00004-g4e57edc3e062-dirty #5 PREEMPT(undef)
Tainted: [N]=TEST
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
RIP: 0010:get_hierarchy (security/landlock/audit.c:142)
Code: 83 e8 02 e8 18 00 84 c0 75 02 0f 0b 48 83 c4 08 48 89 d8 5b 41 5c 41 5e 5d c3 48 c7 c7 00 f3 21 83 e8 e2 e7 18 00 84 c0 75 e2 <0f> 0b eb de 48 89 75 e0 e8 a1 a9 a7 ff 48 8b 75 e0 e9 76 ff ff ff
// snip //
Call Trace:
 <TASK>
test_get_hierarchy (security/landlock/audit.c:178 (discriminator 5))
? test_get_denied_layer (security/landlock/audit.c:158)
? lock_repin_lock (kernel/locking/lockdep.c:5649 kernel/locking/lockdep.c:5978)
? __lock_acquire (kernel/locking/lockdep.c:4675 kernel/locking/lockdep.c:5189)
? _raw_spin_unlock_irqrestore (./include/linux/spinlock_api_smp.h:151 kernel/locking/spinlock.c:194)
? find_held_lock (kernel/locking/lockdep.c:5348)
? trace_irq_enable (./include/trace/events/preemptirq.h:40 (discriminator 17))
? trace_hardirqs_on (kernel/trace/trace_preemptirq.c:80)
? kvm_clock_get_cycles (./arch/x86/include/asm/preempt.h:95 arch/x86/kernel/kvmclock.c:80 arch/x86/kernel/kvmclock.c:86)
? ktime_get_ts64 (kernel/time/timekeeping.c:318 (discriminator 4) kernel/time/timekeeping.c:335 (discriminator 4) kernel/time/timekeeping.c:907 (discriminator 4))
kunit_try_run_case (lib/kunit/test.c:400 lib/kunit/test.c:443)
? kunit_try_run_case_cleanup (lib/kunit/test.c:430)

