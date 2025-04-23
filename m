Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F37171FDD
	for <linux-security-module@vger.kernel.org>; Wed, 23 Apr 2025 04:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745384227; cv=fail; b=p/XQKx1K947bnr7+5RIVjHAbWKFXQAz+2G6zkOU5gbCvT60q6mQppeN+/0YUblwFwTcNRP8dfeYANeein6Zn58B4Fl99+qG9QfSpTSIStVhA4VKnzSpDuyv3BltZRKu7EwIB1frOJS5/C27KxAfs8Fxvap7XLOkg3zCu6VSuGmI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745384227; c=relaxed/simple;
	bh=ts0bbawD8bbUJTXavq7hM3xVcsdYsm2rnleJ6BEukBM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NmiHPKtdXdz9ziI4CQ+spuPfS6Q54qv8rx0syO63N0Okw6x+aOdsjiTxuroeYl4ukFtXq3GD9TE1BSIcnkN01BqOAcDIeQqZAsBFog97T4KtgM5Ibv1M075CdRc+hyg3qMFfzFmxPndtkX3V4et3Inj2QUZ0zg+nZs5t606jIuw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=LXpvbRZX; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="LXpvbRZX"
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 53N4f0Z0002300
	for <linux-security-module@vger.kernel.org>; Tue, 22 Apr 2025 21:57:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	s2048-2021-q4; bh=ts0bbawD8bbUJTXavq7hM3xVcsdYsm2rnleJ6BEukBM=; b=
	LXpvbRZX5/qQ7y0MXn3Qm0baGjj8LaTZT7yCF8IdEtpC3w6aCg57v/FNRjo6rfNy
	YFtsPOGrZ1oJHtchtER/oENkzNbx9OOnPOfiMw1YgaCiz5XGOPjNPnRcPN1JJWzy
	w+VeVuneoo7w3Q3L0O1twdxqYxywM6pQsjTjAlvMHKsdvxLsQiZwfhIhzcP2u6Pn
	R3fyl08OkpYXdM2b8Q+Th7WfDvg/VrwB8sJ4hiME65Cg8ciK2WbTIGCy9XkKM9ko
	42VAfEWrzuH/kg7XN0dQ6gd7g7Q5Ox9Qji7GHNURWo9+ullbTFOBVIKCjN247KM7
	fmc58mCQNDlCedkTTm3bNA==
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2042.outbound.protection.outlook.com [104.47.74.42])
	by m0001303.ppops.net (PPS) with ESMTPS id 466jjsjsqr-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-security-module@vger.kernel.org>; Tue, 22 Apr 2025 21:57:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=smnLf+0kvQ9ZvvczcqGg+bEVDVjF9TyDgT5I8wRYbn+Gchq0NYysjSQhxZG9YOKPDRY3Vk5e4OmiGNXqk0i0LYiwpXrxmS6CQok0kqDJ1NRpvnYkOmQQ7rX49yIBv0PvKTB195Jtr4rSIZ+zUTRE0Q6UYdNIH8tPlIXh/o/b4doO12W3LbXbLHpM0VDWMYcUVLnVYvcVZyP0wGbNDe86Gla8lYNHCJc0PE1iCP++ftvp++6okzfmW13S9KEseio/lTJAbwgvq9CtSMVL3AUVRE/PD8Rw7da7O7G+AN0ux9NRrjm9MpRL017O4q0g+vgpPIEyTfAjn8SV9wieO/Mtnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ts0bbawD8bbUJTXavq7hM3xVcsdYsm2rnleJ6BEukBM=;
 b=SrKHiqn+eI8RtZsRmOulc0g1of6K80nnJylZ4UZ1/zossee4YAiYSyT4J/T8cN/KX1WVTgvUsorCdNc2guRw3LlAeIMS42Lu3AipZeC33QoUHdR/Vfz/yG+7oZNZVr5qit5LJAbmq6cAMnhG8z3ylQ2cAairH6lGxtuxlTo+URJtBpm0i1ns0Og7AIQkcS2mIjd+VxclSOfg4CzomL/FxbkrgE/rAw3A5x9UZsk2lrRePU2dqNgnVEzzFzn487NlMghtvS1aDUdFnVRL+feTAZQYppqvmfGgGTGkweHwCEAJSPQYbAY2E3NRJ5gnBSDGpuAgp1ZzDi0Lx94L5yUvrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by CH3PR15MB6020.namprd15.prod.outlook.com (2603:10b6:610:156::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.35; Wed, 23 Apr
 2025 04:57:01 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610%4]) with mapi id 15.20.8655.033; Wed, 23 Apr 2025
 04:57:01 +0000
From: Song Liu <songliubraving@meta.com>
To: Paul Moore <paul@paul-moore.com>
CC: Song Liu <songliubraving@meta.com>, Song Liu <song@kernel.org>,
        "linux-security-module@vger.kernel.org"
	<linux-security-module@vger.kernel.org>,
        "jmorris@namei.org"
	<jmorris@namei.org>,
        "serge@hallyn.com" <serge@hallyn.com>,
        Kernel Team
	<kernel-team@meta.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Subject: Re: [PATCH] lsm: make SECURITY_PATH always enabled
Thread-Topic: [PATCH] lsm: make SECURITY_PATH always enabled
Thread-Index: AQHbs7aOIBtSOHMWUkq0IJkxn3NAybOwGPSAgAAKroCAAAuzgIAAgX0A
Date: Wed, 23 Apr 2025 04:57:01 +0000
Message-ID: <60CAF154-DADA-4C46-ADE8-403318EFDDAD@fb.com>
References: <20250422184407.3257964-1-song@kernel.org>
 <973cedc0d38496b2096992bf68c72e67@paul-moore.com>
 <3897DD89-5B9F-4257-B273-A4DDEDACD56B@fb.com>
 <CAHC9VhShOxu4Q9yV3tkST3P9SoiL3j3ET_O4_cPAV1ES5usd-A@mail.gmail.com>
In-Reply-To:
 <CAHC9VhShOxu4Q9yV3tkST3P9SoiL3j3ET_O4_cPAV1ES5usd-A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.500.181.1.5)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5109:EE_|CH3PR15MB6020:EE_
x-ms-office365-filtering-correlation-id: a3ef6e09-90a4-4bbf-8942-08dd822348a5
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?MTVOOVdsN3hqdmg2SUM5aU80dm9nZG1mYnY0dFNHQzhTSG1yVkJDZ0lvZlE2?=
 =?utf-8?B?SExyVE1lZWRxK2Jqa1lyUmVseEgwbUltMEo5TnNJV0hBWHRkRTdlRmNtKzVt?=
 =?utf-8?B?K24yUHJjWlh6TXRUNmpoZ2ltbVl3TjhrMFJwWjNmQ0I4UGlZQ3g2R0M0dFpF?=
 =?utf-8?B?ZjV6Yk10ZFFZdXl1Y2s4ZkRPMUZGU3Y3TmlVSG5tY25YUVBoQnc5TS9BSHR5?=
 =?utf-8?B?MzFYUmZUNDcwYlJ3ei9SRGJVWSs4bHViN1AreWJZZ0wxd0JvZXJjRXUzNjVV?=
 =?utf-8?B?SE9leEp0TWRabTZic0oyQlVqa21PSHFzNFhMQXA5b2ljTER1emhMekE1RU9i?=
 =?utf-8?B?MHFVRWM5WDl5ZUxQL2hVNGZmQXdBRXZvZk9FREtxOEd3eUtxbVY5L3BZNXhF?=
 =?utf-8?B?WGhTa05GaHNaMUtidVU3ODV4WjNHYmE5VUNDZzEzWWNSMnZNMlhxakdxaDFn?=
 =?utf-8?B?QTBSS3k3bUR1VC9VNy9nMnFmdW1wWGpqeHBzSzJ2ZFdVZlA1VnpQMmQ5WU1p?=
 =?utf-8?B?d3pkRHlmeDJ0MTN5bm82SlNpeFpnOHQ1ZFVIaWVCa3RTMk8rS2lnQ0VsaHVZ?=
 =?utf-8?B?bUVic29PNkNzWkxOaWFqZHdZN25adU1PbUpRbHBTcXFWN3l0Z1pVOFgyNEp2?=
 =?utf-8?B?blhBbHBRbVVQTStXUEZFT1NqeVJwLzdTM2FsT1I3c2I5RUhaUDcyVWhZTnBE?=
 =?utf-8?B?eFkzZlZLY3l3bGlCejhJSE1lbm5WWXk0MldwK29mY2pEdzg5VnBQNDMvMzNP?=
 =?utf-8?B?amFMUVl6M29EMDdMRFdCdnh4UWJTdnRRaFZaSVFoZTF0UktkT05uK1pNUUow?=
 =?utf-8?B?RmUxbGVKNk1IbkJKbCt1VEpSTW1rdXh0cXplckdFcTRleXVJVENLd0tTZnZL?=
 =?utf-8?B?aFhrU0RzRVY3OVM3Y2JLdkdRbEYyVWRTYk5DUXRtOGpabzlEOXBpRUNVRFNC?=
 =?utf-8?B?MDR5bjRlVlFpcVNFR21KU29ZOHc2b1NPOHIzRUdVS1h2YVR5WTFSeHcwbFIx?=
 =?utf-8?B?YnZESjZRNkhxUlRTUVUvS0NoaHhMY3U1U3YyYTRQNkpqaUJuWWRSMlphTTVj?=
 =?utf-8?B?NVBSVlVKZUMrUmV4Z1VvcXNhT1RYZFlWMlV3UnlLNmdMMXpZS1pVcUdZU3VP?=
 =?utf-8?B?ZWtnOW5YeEZKYXJjY1pWN0pSMmFBTU5KdnVoU2hLbDMwamhraDFpRDMrQW1U?=
 =?utf-8?B?MXlPQ3l2a1RqSUkwdkpKdzgzYXcwQktsSjhzV0ZDUnFkQTVDcU95L3BqOFlZ?=
 =?utf-8?B?dmY3WUlqTE1mdG9JUUMyNWlNSit5dWxrak9Nek5oT2ZST29OSXNMbHJwbGRQ?=
 =?utf-8?B?a2d3V0J1YmVPTTNvc1NseDFsTldXK3pSTGhkcGc4Z2dEZ05BL3lxZ1F5NkZ6?=
 =?utf-8?B?SjRDVUlobERwS2ZkbS9FQmo4bmpxNXU4alRzZkZXZ3oyODBzMUV5Sy96eVRm?=
 =?utf-8?B?eDNyVkQ5dmJrbDk1Q0QvZkxtVzNaT1ZQT3ZHNzFPZXc3eExIOXA5UGlxNU83?=
 =?utf-8?B?SUYyOGFGbml0dWdEaGZRUWZGS0d3UDYwU2VNSk1GQjc1c3NINy9pdjZzQWZH?=
 =?utf-8?B?dFA2c1RkWWJEV1d1YWZIQU10Wld2YW0vTEZDdmFNUUJUTFR3Z25vdHI0UkI3?=
 =?utf-8?B?bW9xRDV1eERxY0o3bDIzMi9jNnBSdHhHWndwNkJiWUdILzVwQ3UyOFBXRFNM?=
 =?utf-8?B?YkJNVHhubjE4c0FvRUdFa00wcExodGdtdXZuRUpxSmxqcUxJbjJXVXFpTnlH?=
 =?utf-8?B?VmxTbUNmUzJEaW1seTRpeUk4Z2pSenBHRVA2TUVVcC9SRzBmbUx4Z2MwUTFa?=
 =?utf-8?B?ckU0WnlSbmJDbmJuS2dpN1pKS2JueVNONmkvZVVRL25xY1ZSbHN3TVdzcUY2?=
 =?utf-8?B?ejFQN2kwZ1JLeWxBS1BkSEgxLzZBaHFJOVlzaTNvVnFsSWY2ZG5FOGhzRDE1?=
 =?utf-8?B?RE1LdXhBOUl6aDZaOWpKS1RMOWhiczE3enJuRkxhNUpmNS9oVEZNSGx4Z28x?=
 =?utf-8?Q?r6WL9Rs7KO84rfa8JS2rBpfUoZNxK0=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cmtkbHlVNUlRQ29yR2g3QnFBN01YNXIvbVBOaTk4bWdBZmJpTTFldk5GT3A2?=
 =?utf-8?B?TVhGQmluV1lLRko0bHV4UjhqWXJOMEZYWU0yWmFtRWd2djduYnNVRkU4bVBM?=
 =?utf-8?B?aFlsTE9UekEycDA4elY2V0tia2IrTGVPQ0pITElScTBIa0pwRmQyc0hlSnVt?=
 =?utf-8?B?TTdrNHkzVjdUdU52NVVKVlJFYmVaem02SWtwbzl3TkdQNzBZeklKcE5JVEcr?=
 =?utf-8?B?SEdYUHhVSlp6TFdBT2cwcklYbm1QYnUxV0JYN28vcHNWNHdtOVF2citQT0Nn?=
 =?utf-8?B?RlNFOU80aUplZFIrTHNFVzNWOGh0UWxmdEMrK1F0KzhVdzg2dEZFN2JnUmNo?=
 =?utf-8?B?NEVqYzFJR1JDNU9tOE9LNVVoMGNwcnpMRGcxbmpPVytQNzFlRjBzNUd5YTQ4?=
 =?utf-8?B?VWdjTXV6Qk9zWHJwK2xtSWkxUFpUYVB0Mk91bEhSS2pLRjJIaVRxMTk1MjFG?=
 =?utf-8?B?OStOMlZqbm9RRlhqMi9xM2I0Rnp1eWR4Y0xkSVBzNlRLRHdqMVpncFlrMTNs?=
 =?utf-8?B?eXpFcTNxVW14ZmlEOWd4YlVGUnhHcHBCdUY1UDNtWGt2ZTN6bHJXUDZiQXp3?=
 =?utf-8?B?bEJid1BXcnZKSkRjZDllZ21qWDZtQlAvVk9uK2ZCQ2FMaDVKY2UvN1J1WVBs?=
 =?utf-8?B?R0FIU1VYN1c1Uk1QaURpUFdMc2hHZHdFaFg3YjJBWlo0VXZIcmkxRUp4b0t2?=
 =?utf-8?B?aVhjN2d1SEd3eFJOZGJiUFFCbWMvTzZpdGhMeDBBQ2VlVkg2cnVQcnR3STJa?=
 =?utf-8?B?QjJNMjUzYWhjZHdMeHpqVkxqdmZBK0o0UDZyRjhwaWc0Z1FOTXlOcUVXUDZk?=
 =?utf-8?B?VS9TbzBMQXBLVVluZ3RwU2pYeExYZUt6YlVqUUcwUmkwb0UxMGovdkNKTEtZ?=
 =?utf-8?B?Vi93RXg2ZkFCU1NvYjNpamdHZGl0QUtEY2hYNWpxNHFtY1JzYjBnSG9McWVI?=
 =?utf-8?B?VHBXMTJ3aHVZV3QwVTUrZllPRTZYMkhTblpXVTFjdG1xS0pMVUpMWlFiWmps?=
 =?utf-8?B?UDRDcFZOU3laRU1mUzBQd0tMSFNsQ2hieE83WTRWVDl2VG9EaUVPYWxYcjAx?=
 =?utf-8?B?WWsxcC9hNXdHT05GNGpDeXpkZk0yYkZYS1JWcXQwZWt3Sk5IWXZ6ZWdGSHlz?=
 =?utf-8?B?ejZiWlBFUWV0OTdXUGtERWhWTTM3cnh1Nnc2bDJzNGlFWEo1a0ExcUpCWnRk?=
 =?utf-8?B?bEpHaklkZGo4N1BlS2pWcHpBTUF1SkhJUElOMzNFbkhkb1ZWeFl0c3RTOU55?=
 =?utf-8?B?Uk1mT2xqeEhWc0IxUjZ6STJzZHdZelpySzFmS1crNUdUbmdWYXVHWU5jUEl2?=
 =?utf-8?B?R3o4KzJWWWtreTVNQ1owNC9WM25jVzg1QkRCUHl1dHZhc2Nwdm83YzFNaFZr?=
 =?utf-8?B?Q2V0all0dWRkaXA4Vmo2Z2hlbUxLbnQrLzhQeGdFNHc0L2NpSGtZK3lSMTdX?=
 =?utf-8?B?USt2RUVIOG9zVHBTK2J6bURrVDRnOUZBVnVGYUJNd2g2WU5oK2tnYVhjdlBN?=
 =?utf-8?B?b2dQM21CMlBMcHQ5U2VBVm1NWGNPS0tKWklSOVpzUUxSUVpwUFdaL2g3anVO?=
 =?utf-8?B?ODR2RXlhYUh3dU1NMFZvdzFhRDl4UmEvVEVXV0ZvVFlQeGJ6d2ZPOVdDU3VY?=
 =?utf-8?B?ZWZoZmJzZTIxcHZjYjkvbWVRK3ptR3h5NjNCYVBlZktYNTdzR1hDQlY3Mlp0?=
 =?utf-8?B?UTZkOGc2TUp2VUpPOGNTa3J3Q3NSU1VKT0RNQzRDMnIvVnRMTGYvaVhySzM1?=
 =?utf-8?B?UVoxWWY5MGNRRmcvNXI2N1ZZTjA4cEtJQlJSenVzWkQwYkdpTW13L2JaQSs4?=
 =?utf-8?B?Y0toTWcwOG1vUlo5eWNsL3B5dHlXd1hMTDVDL2VoSzFQNXJnaHkxdkRuOHk2?=
 =?utf-8?B?YmN1dzByQVlNQ0l5R29qL1p1WmwxWEVaVzJjdjUreVR1NXNFUFBRekVBZkJ4?=
 =?utf-8?B?TUZCVTY4WjJBMyswdXZoVlpEM21QNncrQTFRdG42bC9YNFB2NnZYK2hzS1Bn?=
 =?utf-8?B?cUlqa2Z0U0FsbUxQRDZmRlVhckwwa0xRNEFDMzZ6Z1VKQk44UUovMXRsSi90?=
 =?utf-8?B?ZFR6cXRDZVpNZTZ6YlMvT0ZiZnJxbnlQUGc3OG5kNnFmbVc4VXgzcDVSNGts?=
 =?utf-8?B?Rkw1RHViZkJOS3BaZXQ0M0hpOCt1RTNDbnFFUG5LM1JJVlNpZlJhR01yMldT?=
 =?utf-8?B?dWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0619CC95DA653F418EBB789B61DC5333@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3ef6e09-90a4-4bbf-8942-08dd822348a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2025 04:57:01.0196
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cAGeH1an4YvsU6t55PLnxTh4ycvcsSgRHYSLosbh+v9/La5CuF2ndMVQ3+R4oNTg4T31MONW1ZpWStSORlPJ2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR15MB6020
X-Proofpoint-ORIG-GUID: GTZXtuDtXMhaSrOCz8FBZJtWp5zTjFPX
X-Authority-Analysis: v=2.4 cv=MI1gmNZl c=1 sm=1 tr=0 ts=68087320 cx=c_pps a=CZyBIZNk7+VlD+/eRBofeA==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=XR8D0OoHHMoA:10 a=xVhDTqbCAAAA:8 a=TiGIucSvIg1tWpQBUNAA:9 a=QEXdDO2ut3YA:10 a=GrmWmAYt4dzCMttCBZOh:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDIzMDAzMCBTYWx0ZWRfX+XgnWV8/alpK 97Rk4Fs4V4N7oAAxUh+m+FEWV5LH8/dZW4ofH9CZIoF//R1tz7hAkQftPiqFF1wQe2K24J5dg60 RNDDn8w+mdeP2ucmlmFGvEX0UtasA6RicacrG8+Lo7+Z0YbIglWgAr5FGO3PMrrYn3xt9XI3Rjn
 U7UU/m9O6F72AwNplRZ4eIAvssqQsoqpxU1dMIi5Zvm1qSXwpJWCgFAp8cH4Vz+CK2RZXg2mdkl M55G0qtAsD0zC0s48HX3LElU1LF8pxugNybqU5wUj+lV8TLOQACQSvfQ3UwtXRlHgcGf5WFUDjA tSmL5WRM1aU+VTqi7+TmaRnVMq4c4CaFL2lsYHpZb9lvBRvFwyUEAhgvTkHiOEwLLDte3UO3onT
 qd64niUttK/lupYN100YvbF3y75YpONtlFIWJnc5ojVjrZEUzQCZ/eZw4UhewpJbpTBt+/h4
X-Proofpoint-GUID: GTZXtuDtXMhaSrOCz8FBZJtWp5zTjFPX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-23_02,2025-04-22_01,2024-11-22_01

SGkgUGF1bCwgDQoNClRoYW5rcyBmb3IgeW91ciBjb21tZW50cyENCg0KPiBPbiBBcHIgMjIsIDIw
MjUsIGF0IDI6MTPigK9QTSwgUGF1bCBNb29yZSA8cGF1bEBwYXVsLW1vb3JlLmNvbT4gd3JvdGU6
DQoNClsuLi5dDQoNCj4+IA0KPj4gSG93ZXZlciwgSSBkb24ndCB0aGluayBleGlzdGluZyBDT05G
SUdfU0VDVVJJVFlfKiBhcmUgZG9pbmcgdGhlIHJpZ2h0DQo+PiB0aGluZ3MuIEFtb25nIGFsbCB0
aGUgY29uZmlncywgQ09ORklHX1NFQ1VSSVRZX1BBVEggaXMgdGhlIG1vc3QgYXdrd2FyZA0KPj4g
dG8gbWUuIFNheSAsIGlmIHdlIGhhdmUgQ09ORklHX1NFQ1VSSVRZX1BBVEgsIHNob3VsZG4ndCB3
ZSBhbHNvIGhhdmUNCj4+IENPTkZJR19TRUNVUklUWV9JTk9ERT8gSU9XLCBzb21ldGhpbmcgbGlr
ZToNCj4+IA0KPj4gI2lmZGVmIENPTkZJR19TRUNVUklUWV9JTk9ERQ0KPj4gaW50IHNlY3VyaXR5
X2lub2RlX3JtZGlyKHN0cnVjdCBpbm9kZSAqZGlyLCBzdHJ1Y3QgZGVudHJ5ICpkZW50cnkpOw0K
Pj4gI2VuZGlmDQo+PiANCj4+ICNpZmRlZiBDT05GSUdfU0VDVVJJVFlfUEFUSA0KPj4gaW50IHNl
Y3VyaXR5X3BhdGhfcm1kaXIoc3RydWN0IGlub2RlICpkaXIsIHN0cnVjdCBkZW50cnkgKmRlbnRy
eSk7DQo+PiAjZW5kaWYNCj4gDQo+IFdpdGhvdXQgcHV0dGluZyBtdWNoIHRob3VnaHQgaW50byB3
aGF0IHdvdWxkIGZhbGwgdW5kZXINCj4gQ09ORklHX1NFQ1VSSVRZX0lOT0RFLCBJIHRoaW5rIGl0
IHdvdWxkIGJlIGludGVyZXN0aW5nIHRvIHNlZSB3aGF0DQo+IGhvb2tzIG9uZSBtaWdodCBiZSBh
YmxlIHRvIG1ha2UgY29uZGl0aW9uYWwgb24gc3VjaCBhIEtjb25maWcga25vYi4NCj4gVXNpbmcg
c2VjdXJpdHlfaW5vZGVfcGVybWlzc2lvbigpIGFzIGEgc2ltcGxlIHRlc3QsIGl0IGxvb2tzIGxp
a2Ugb25seQ0KPiBTRUxpbnV4IGFuZCBTbWFjayBwcm92aWRlIGltcGxlbWVudGF0aW9ucywgc3Bv
dCBjaGVja3Mgb24gYSBmZXcgb3RoZXINCj4gc2VjdXJpdHlfKmlub2RlKigpIGhvb2tzIHNob3dz
IHNpbWlsYXIsIG9yIGV2ZW4gbW9yZSBsaW1pdGVkLCByZXN1bHRzLg0KPiANCj4gWW91IHdvdWxk
IG5lZWQgdG8gc3BlbmQgc29tZSB0aW1lIHRvIGRldGVybWluZSB3aGF0IExTTSBob29rcyBhcmUg
dXNlZA0KPiBieSB3aGljaCBMU01zIGFuZCBhZGp1c3QgdGhlaXIgS2NvbmZpZ3MgYXBwcm9wcmlh
dGVseSBmb3IgdGhlIG5ldw0KPiBDT05GSUdfU0VDVVJJVFlfSU5PREUga25vYiwgYnV0IGlmIHlv
dSBkbyB0aGF0IHRoZW4gSSB0aGluayB0aGF0IHdvdWxkDQo+IGJlIG9rYXkuDQoNCldlbGwsIEkg
d2FzIGhvcGluZyB0byBzaW1wbGlmeSB0aGUgQ09ORklHcyBieSByZW1vdmluZyBvbmUuIFNvIEkg
YW0gDQpub3Qgc3VyZSB3aGV0aGVyIGFkZGluZyBhIG5ldyBDT05GSUcgaXMgdGhlIHJpZ2h0IHRo
aW5nIHRvIGRvLiANCg0KPiANCj4+IE9SLCBtYXliZSB3ZSBzaG91bGQganVzdCByZW1vdmUgc2Vj
dXJpdHlfaW5vZGVfcm1kaXIoKSwgYW5kIHVzZXJzIG9mDQo+PiBzZWN1cml0eV9pbm9kZV9ybWRp
cigpIGNhbiBqdXN0IHVzZSBzZWN1cml0eV9wYXRoX3JtZGlyKCkgaW5zdGVhZD8NCj4gDQo+IFRo
b3NlIHR3byBMU00gaG9va3MgYXJlIGNhbGxlZCBmcm9tIHNsaWdodGx5IGRpZmZlcmVudCBwbGFj
ZXMgaW4gdGhlDQo+IGNvZGVwYXRoIHdoaWNoIGhhcyBhbiBpbXBhY3Qgb24gdGhlaXIgZW52aXJv
bm1lbnQuICBGb3IgZXhhbXBsZSwgdGhlDQo+IGlub2RlIHZhcmlhbnQgZG9lc24ndCBoYXZlIHRv
IGRlYWwgd2l0aCBkaXJlY3RvcnkgaW5vZGVzIHRoYXQgZG9uJ3QNCj4gaGF2ZSBhIGRlZmluZWQg
cm1kaXIgb3AsIHdoZXJlYXMgdGhlIHBhdGggdmFyaWFudCBkb2VzOyB0aGUgaW5vZGUNCj4gdmFy
aWFudCBkb2Vzbid0IGhhdmUgdG8gd29ycnkgYWJvdXQgU19LRVJORUxfRklMRSBmaWxlcywgdGhl
IGlub2RlDQo+IHZhcmlhbnQgaGFzIGEgcmVmY291bnQnZCBhbmQgbG9ja2VkIGRlbnRyeSwgZXRj
LiAgTW92aW5nIGFuIGV4aXN0aW5nDQo+IExTTSwgZXNwZWNpYWxseSBjb21wbGV4IG9uZXMsIGZy
b20gb25lIExTTSBob29rIHRvIGFub3RoZXIsIGlzIGENCj4gZGVsaWNhdGUgb3BlcmF0aW9uIGFu
ZCBtaWdodCBub3QgYmUgd29ydGggaXQgZm9yIHN1Y2ggYSBzbWFsbCByZXR1cm4uDQoNCkdpdmVu
IHRoZXJlIGlzIHB1c2hiYWNrIHdoZW4gYSBuZXcgTFNNIGhvb2sgaXMgYWRkZWQsIEkgYXNzdW1l
IA0KcmVtb3ZpbmcgYSBob29rIChvciBtZXJnZSB0d28gaG9va3MgaW50byBvbmUpIG1heSBiZSBh
IGdvb2QgbW92ZS4gDQpXZWxsLCBpdCBpcyB0b3RhbGx5IHBvc3NpYmxlIHRoYXQgSSB1bmRlcmVz
dGltYXRlZCB0aGUgY29tcGxleGl0eSBvZiANCnRoZSB3b3JrLiANCg0KVGhhbmtzLA0KU29uZw0K
DQo=
