Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530A454BC5;
	Mon, 18 Mar 2024 17:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710781398; cv=none; b=Fl2FSCLUlzrqmTdkv4dpZnNpG/XRu+vlMKDv192XFIdb8Gm7GAqeR2Zzt9+SYXRuNZ3UNH1YaYMxwCUZm2VxdSv618gXsspWNOPmC5BwBosfAOpRD5FngoFktlVAly6DU05hLUkRFBdkjjyuhA3ylzhlwyM0BsCH3t+7xCS6Des=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710781398; c=relaxed/simple;
	bh=PV92R+PCAVCQeCeiYFj99emp2ty2ynIp1scMWuaHx0E=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LKJHRD8Wk50waM0/26iVtOhZ+8/VNUUInbwykQzM88YnORw20zMFSEXKKXLrd3mzg+VLrqEXUnc3c/3awY6Bf3FmpqrZt4YOAyKfXDwXhQ59951kgMn2icB1sSlVOXX6eKhLbQQ+Q4Wrn/XEGDvMFth/sa5dzdcuHehQgkKfamM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4Tz13m5zs1z9xs5X;
	Tue, 19 Mar 2024 00:47:16 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 54200140123;
	Tue, 19 Mar 2024 01:03:10 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwDHvhe5c_hl+2KQBA--.54320S2;
	Mon, 18 Mar 2024 18:03:07 +0100 (CET)
Message-ID: <2b49cd00bb85b7310db12014eea16c72d8a9351c.camel@huaweicloud.com>
Subject: Re: [PATCH bpf-next 0/5] Fix kernel panic caused by bpf lsm return
 value
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Stanislav Fomichev <sdf@google.com>, Xu Kuohai <xukuohai@huaweicloud.com>
Cc: bpf@vger.kernel.org, linux-security-module@vger.kernel.org, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>,  Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu
 <song@kernel.org>,  Yonghong Song <yonghong.song@linux.dev>, John Fastabend
 <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,  Florent Revest
 <revest@chromium.org>, Brendan Jackman <jackmanb@chromium.org>, Paul Moore
 <paul@paul-moore.com>,  James Morris <jmorris@namei.org>, "Serge E .
 Hallyn" <serge@hallyn.com>, Khadija Kamran <kamrankhadijadj@gmail.com>,
 Casey Schaufler <casey@schaufler-ca.com>,  Ondrej Mosnacek
 <omosnace@redhat.com>, Kees Cook <keescook@chromium.org>, John Johansen
 <john.johansen@canonical.com>, Lukas Bulwahn <lukas.bulwahn@gmail.com>, 
 Roberto Sassu <roberto.sassu@huawei.com>, Shung-Hsi Yu
 <shung-hsi.yu@suse.com>
Date: Mon, 18 Mar 2024 18:02:45 +0100
In-Reply-To: <ZfhxRZR9ejNt8mgN@google.com>
References: <20240316122359.1073787-1-xukuohai@huaweicloud.com>
	 <ZfhxRZR9ejNt8mgN@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:LxC2BwDHvhe5c_hl+2KQBA--.54320S2
X-Coremail-Antispam: 1UD129KBjvdXoWrurW5ArWfZw17KF15WryrXrb_yoWfJFgE93
	40qr9xGwn5Jw1Iqan7ZFyS9FZ7KFy8AryYya1UtrW3C34xArn7CFs3Cr93Zas3A39YqryF
	qas2yrZFqr1avjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb7xYFVCjjxCrM7AC8VAFwI0_Wr0E3s1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267
	AKxVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42
	xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
	c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UAkuxUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAGBF1jj5uFNgAAsa

On Mon, 2024-03-18 at 09:52 -0700, Stanislav Fomichev wrote:
> On 03/16, Xu Kuohai wrote:
> > From: Xu Kuohai <xukuohai@huawei.com>
> >=20
> > A bpf prog returning positive number attached to file_alloc_security ho=
ok
> > will make kernel panic.
>=20
> I'll leave it up to KP. I remember there was a similar patch series in
> the past, but I have no state on why it was not accepted..

Yes, this one:

v1:=C2=A0https://lore.kernel.org/bpf/20221115175652.3836811-1-roberto.sassu=
@huaweicloud.com/
v2: https://lore.kernel.org/bpf/20221207172434.435893-1-roberto.sassu@huawe=
icloud.com/

The selftests were failing, and I wasn't able to come up with a
solution on the verifier side. I see patch 5 goes in that direction,
and I remember there was related work in this area.

(just saw Paul's answer, maybe the new KP's patch set also solves this)

Roberto

