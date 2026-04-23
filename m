Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0549935C19F;
	Thu, 23 Apr 2026 22:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776984798; cv=none; b=DT+ukjtjP+w3qC1MruEolhdxbU1NseeTE+pgWmJ/Pqc/B78dO2RCE9PRs/D8PAklLeuGdYcsEkLxhfL22ON8l8/RwjdaTwqxqbhvguKRdH3r2zEmQ4KY4OzED1PN9nh1OSNpVBUnCzIT215np5InbU9ROtYxc0uMxgGdFOCYg2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776984798; c=relaxed/simple;
	bh=nBdr1L4KtwUodAfRKBBP7dJ1bWfLPWcLF5VYaVeAk3Q=;
	h=From:Date:Message-ID:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VbTTRFBP/o0EZNLgtyFsMk29eCamrbSjZ0nWoUEk0sYUoWNMTo+RplUNpR1lVg5vsgPKJzopx/RHOnNXQIjGhsbKU6Ggb1UGwsdCPrviDM+i4bbiETMgE30gqwVMAi/S/1HZ9NDKqdFApJ2ADcTlm8PNCedkqtOpFW9PkX5P+tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from 09-tomoyo-drop.eml (unknown [111.196.245.116])
	by APP-05 (Coremail) with SMTP id zQCowAC3TBDPouppV5BsDg--.55057S2;
	Fri, 24 Apr 2026 06:53:04 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
Date: Fri, 24 Apr 2026 06:53:03 +0800
Message-ID: <20260424070109.1-tomoyo-drop-pengpeng@iscas.ac.cn>
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: Kentaro Takeda <takedakn@nttdata.co.jp>, Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, Serge Hallyn <serge@hallyn.com>, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, pengpeng@iscas.ac.cn
Subject: Re: [PATCH] tomoyo: reject short exec.envp[] names before suffix checks
In-Reply-To: <20260417073249.93906-1-pengpeng@iscas.ac.cn>
References: <20260417073249.93906-1-pengpeng@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAC3TBDPouppV5BsDg--.55057S2
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUY47AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E
	6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28Cjx
	kF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8I
	cVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z2
	80aVCY1x0267AKxVWxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IE
	w4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE14v26r1j6r4UMc
	vjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1l
	42xK82IYc2Ij64vIr41l4c8EcI0Ec7CjxVAaw2AFwI0_JF0_Jw1l4I8I3I0E4IkC6x0Yz7
	v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF
	1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIx
	AIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4l
	IxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvf
	C2KfnxnUUI43ZEXa7VUbLZ23UUUUU==
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/

Hi Tetsuo,

Thanks for the explanation.

Agreed, I missed that the left-hand string is already guaranteed to be
safely dereferenced at that call site. I'll drop this patch.

Thanks,
Pengpeng


