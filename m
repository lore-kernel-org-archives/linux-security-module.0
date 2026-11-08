Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.25
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794139036;
	b=J/LUumLoGXc8Dk8L4DZS+pSPqZwocL4Jrh9z/XwxoU0f2JHFG6RgHYQlZTly1w4IV9uA
	 lgJ8Ry+uQzZxhRV4phgL4WusWl2ftJZekNRAeX9c3wpjihNqxj+UY1BM9d3KZ/yRnkVGa
	 MdpMQ2AnguHQLuUMGHdbosJY28iatfA+i9U3+cCPUbnFsK/w8HpVXeFKSu4gQ5Hz5usuT
	 6Sakz2oVtDpcpZuMJ0eEu3KLgKuzyEYOQJMIsonap0jJ2R6hRfnfiv3bDphX6q+uicbqK
	 9C4nEhizIzQKvcXIPp15m0RMCnhnLHwiFKtBg1ZW63VSJ9PjNg5xkdT65ewYH1v+0aw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794139036;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=LA04o6F/GVQrfAhvN9QN+XhNGko58dQFSaUFxZw+K0w=;
	b=FOIxX2sPJdgbK3QTP9ONG5cnVX4mq+gmCnrJoTx19l6yefQ77bdzofyYwNIR5If59tus
	 VRQz+IPaEMWvD+w+YSTbyDurGQGKDCn9SlBLixEI8MKtRZda5E50vzKpFUWB+L6sCcge4
	 L/JCkrO8SaxbsFziKxq9+y3HVr813pwy8/qWz/6LTj92qk9BF7zR7rlIgx7nVQJZtKPgh
	 qqVgWPR6s2BFf61NTUU56PiQN5Pc2pKOkZIY7cFXdXS4CM+P18bxDcg8sedVdI6hnxrGf
	 D6QMcu+f/dwNfQfYTMEeanCe2rENdPEBSB1GPDyQoSHoC8ygc6cKUtXNGYk/LZB19Hg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iscas.ac.cn;
	spf=pass smtp.mailfrom=iscas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.25
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8176E606A321;
	Sun,  8 Nov 2026 11:57:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8176E606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [172.100.0.8] (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowAC3TbONY_Bqd9OaAA--.22241S2;
	Sun, 08 Nov 2026 19:57:01 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: John Johansen <john.johansen@canonical.com>
Cc: Greg KH <greg@kroah.com>,
 Ryan Lee <ryan.lee@canonical.com>,
 apparmor@lists.ubuntu.com,
 jmorris@namei.org,
 linux-kernel@vger.kernel.org,
 linux-security-module@vger.kernel.org,
 paul@paul-moore.com,
 serge@hallyn.com
Subject: Re: [PATCH] apparmor: Fix label reference leak in aa_unix_file_perm()
Date: Sun, 08 Nov 2026 12:40:00 +0000
Message-ID: <20261108124000.3300202-1-vulab@iscas.ac.cn>
In-Reply-To: <da2651ff-ecc8-4b7d-b9f3-99f148844ff3@canonical.com>
References: <20260917164136.2162858-1-vulab@iscas.ac.cn>
 <CAKCV-6uui82r4U3+ab=2ZFQvGQYnxfhYMHJNzLim-HEw6pRp7A@mail.gmail.com>
 <760b1f31-32f6-44c6-8a5b-991f228a327f@canonical.com>
 <2026091851-recent-ungraded-23eb@gregkh>
 <da2651ff-ecc8-4b7d-b9f3-99f148844ff3@canonical.com>
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:zQCowAC3TbONY_Bqd9OaAA--.22241S2
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYa7k0a2IF6F4UM7kC6x804xWl1xkIjI8I
	6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
	8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0
	cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I
	8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
	64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q6rW5McIj6I8E87Iv67AKxVWxJr0_Gc
	WlOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxAIw28IcxkI7VAKI48JMxAIw28I
	cVCjz48v1sIEY20_Gr43Wr1UJr1l4c8EcI0Ec7CjxVAaw2AFwI0_Jw0_GFyl4I8I3I0E4I
	kC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWU
	WwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JF
	I_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWU
	JVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJr
	UvcSsGvfC2KfnxnUUI43ZEXa7IU1nNVPUUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAMFA2rv4qjIgQAAsP

Hi John,

Sorry for the very late reply, and sorry for the confusion. You are right,
this was already fixed by 4483efe4f2151; I was working from an outdated tree.

Please drop this patch, I am not sending a v2.

Thanks,
Wentao

