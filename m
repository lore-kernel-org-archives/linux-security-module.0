Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD84329E6C;
	Tue, 25 Aug 2026 17:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787680226; cv=none; b=mq7Lwx02YlbrqLBT1IHj5SRSPd/YUExfjuWKH8HKxpCScmf0S+ub//lcn/2Wb4KxVL6r2B7MPUb17VwOaM2BmulKxvmeuO+cLbWc0UU0CfU2uTnBwMz3Rmbwn+G8K5YTXfGhUwC6pwgEodViSJrhTQGABc1sruHMc2bL3H6d52s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787680226; c=relaxed/simple;
	bh=TwWm9sANJ5A719tLGPwWcRWEJwAqXNxier+jjmoT8Ew=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=nL84Scay+ntmkepUYW+sjKo7hIh7GdFkOOOay8DAUruPVJI4AyEOb7Rr5elTZWA8pz3gCtpqqyDO+bQ5iOMFpadXEwjKsv76ev99wD/b8ISYEu1c/o/Ptn1CUGQYLTWe15txR6vyqEPQNqQ65wkJlPZPAVnuoxSm3NQuNezO128=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=abk69LX8; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="abk69LX8"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67PEZG0a1141584;
	Tue, 25 Aug 2026 17:49:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=qvrGxz
	d5YGjWdPG/lffvzTsPTp7erEp5bTTOVOj51Fg=; b=abk69LX8VO7Zzt982NNgij
	btpTLhSFAGdkleBTyAgZrkpVrgS+Fy3EOu/I4a+H0RCLZvLwuozAKLo9LztBPo4i
	3Vd3Rx0qxocR0U+zfutXe1XfH1am4B7Pk6lGfeJ6uA0L9cVKJ1k27JNvdvYfAK4N
	xSmYh9w7hNY2IfEoW4v2b1CArL24BCFkzfCiLO57cSeV1NjGpboiNL7CgSLBMT9K
	J1cumdgzLAV8A21RseibswNRJ2IJsE1yIuvj00b4FlOlrHz6i1uSVT9yJ2y8G7jZ
	z8PVZZClj8leLAP325qF4E7OIM69gY82pKp6JwHOosbNkyI+MDwS1CPB+7zHB58g
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73g4st48-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Aug 2026 17:49:56 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67PHgnmS008477;
	Tue, 25 Aug 2026 17:49:55 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7p3q5rpg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Aug 2026 17:49:55 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67PHnsSR16122612
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Aug 2026 17:49:54 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BAE8D58065;
	Tue, 25 Aug 2026 17:49:54 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F168758056;
	Tue, 25 Aug 2026 17:49:53 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.31.108.66])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 25 Aug 2026 17:49:53 +0000 (GMT)
Message-ID: <46bde670fa25f07cc99dddc61ecc6de4d0ee125e.camel@linux.ibm.com>
Subject: Re: [PATCH v2 1/2] configfs: move CONFIGFS_MAGIC definition to
 magic.h
From: Mimi Zohar <zohar@linux.ibm.com>
To: Frederick Lawler <fred@cloudflare.com>, Breno Leitao <leitao@debian.org>
Cc: Andreas Hindborg <a.hindborg@kernel.org>,
        Roberto Sassu	
 <roberto.sassu@huawei.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Eric Snowberg <eric.snowberg@oracle.com>,
        Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn"	 <serge@hallyn.com>, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        kernel-team@cloudflare.com
In-Reply-To: <6k67quhqhibslnmavtbvgnlzbohpgmyfm4yxekl4k5lzqdvr5o@xg3wbmdl5wbt>
References: <20260819-configfs-v2-0-cb6e65d11589@cloudflare.com>
	 <20260819-configfs-v2-1-cb6e65d11589@cloudflare.com>
	 <ao2iHWDZAJf0FRqh@gmail.com>
	 <6k67quhqhibslnmavtbvgnlzbohpgmyfm4yxekl4k5lzqdvr5o@xg3wbmdl5wbt>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 25 Aug 2026 13:49:53 -0400
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: kYOxbdoBZlSgUmpPluxl3jRS_pSXMoKP
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI1MDE0OSBTYWx0ZWRfX7rBAd0rsjNRp
 Ar2oWRZX2BQnfqFASmeCqi0vKUS272ZtFmriG2iaNGELMpGheX/Ywl9i9/Zg5uSAwg1XyzVRV5b
 GvcgQy5/M9h9ASNvMkQosHf52zMLlhU=
X-Proofpoint-GUID: IUAVcQ6cNNyEazX5zowqJy0-90oBvbdN
X-Authority-Analysis: v=2.4 cv=JZyMa0KV c=1 sm=1 tr=0 ts=6a8dd5c4 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=EG7W4yiQAAAA:8 a=lGg8mCHxGARKzGgLr2MA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI1MDE0OSBTYWx0ZWRfX5m2PAPZ5AHD8
 ojC/yP2xaJnCSxEWB+vcxc7cnzh3bc7WKg7lPDjFRElxbBdJf95Hf+WdUrxYLmwTcjenDsi9zrC
 h27YCslteqlM0APj+wlRWPMJAzNfLxIFnkooOCrh5UtnhK7zCsd3OsvVuAJryWwpjlJh4m9Rwn9
 c5zAUmBzuJzMb7Y9B8xrJOUCIvVxSmqAbE71rt0YI88ChIBwKAY+yNAjtuWAp2HEnggw7rzSVnY
 LaeOxd61MIM277tEcSmvNMfJsirhxGtv+lGH389mQUJ8xSHeswc5YTVSfE+6fN0nfV2DFvYQ0iW
 RVsti6QOvkOLEOE3q4vqw+DtEO+LW4+HHeEi8fzqWWeWP96IL/HlpO5UXkVn5GNEDepiWVM5FMp
 TKmePg4lWGYTAX3DgU/yn7TPXfu5LfP5aBFEgnzOS0ZlNAgYFSZ/mqZfa4+GDtQTWDKrxGMgk5Z
 f54jpHCR4A9RNkv74Mg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-25_04,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 adultscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608250149

On Tue, 2026-08-25 at 11:47 -0500, Frederick Lawler wrote:
> Hi Breno,
>=20
> On Tue, Aug 25, 2026 at 07:10:02AM -0700, Breno Leitao wrote:
> > On Wed, Aug 19, 2026 at 06:45:22PM -0500, Frederick Lawler wrote:
> > > IMA shouldn't measure or appraise configfs, but currently does becaus=
e
> > > it's missing from the default exclusion policies. Move CONFIGFS_MAGIC=
 to
> > > magic.h to expose the file system's magic to IMA, as well as other us=
erland
> > > applications.
> > >=20
> > > Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
> > > Signed-off-by: Frederick Lawler <fred@cloudflare.com>
> >=20
> > Do you want this change to go thorugh the configfs tree, or the tree
> > specific for IMA?
> > ?
>=20
> Unless you have a user asking for it, I personally think it makes sense
> for linux-integrity to take it since the two patches are related.
>=20
> I don't mind spinning a v3 for integrity if you choose to take it now.
>=20
> Best,
> Fred
>=20
> PS. Sorry for not keeping the Reviewed-by tag from v1. I usually
> forget _something_ with re-spins until after the fact.

Breno, thank you for the Reviewed-by.  The patch set didn't quite make it i=
n
time for the open window, but I plan on upstreaming them.  Can we change th=
e
Reviewed-by to an Acked-by?

thanks,

Mimi
