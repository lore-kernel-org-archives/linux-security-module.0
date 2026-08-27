Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D133F1052;
	Thu, 27 Aug 2026 20:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.147.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787861040; cv=fail; b=Y/Fw2lHpNGfiymfoRbr8hl98ESicIMoIU/LYEBBEZBEFoq1NwfbZoCtUqCmUuEgy96x8Ne9KLRlxiENC3MBpeKMbMAP/k8MdfFpJIQh0D3W2a+2QAFxXHfjvYu5cNz49/mWqKYbf/tObI4kp6FN9wuxFLUqBHJFq9FsY5QNM8g0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787861040; c=relaxed/simple;
	bh=XM6x+nP1uziASf1+U2y8dPMk656jNzweBBEIJZaRP24=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=onrkOCAHP6M8LZtEWTd7xSjk2mPpiC1YR09/IlospikZnNuGM2CuUVOF+OumvbhdVJ1I3NVbz44xG93qGUQuJostKgWh9N7YluW9Stw1/X6toSzO5rBf1/Am9jmI3+rpIiVmDyugiOveiNMw517chPN8fY8D8P+7WCsKNnQsQZ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=b3AcYJmt; arc=fail smtp.client-ip=148.163.147.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="b3AcYJmt"
Received: from pps.filterd (m0150242.ppops.net [127.0.0.1])
	by mx0a-002e3701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67RJPKGV3687407;
	Thu, 27 Aug 2026 20:03:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pps0720; bh=XM6x+nP1uziASf1+U2y8dPMk656jNzweBBEIJZaRP24=; b=b3Ac
	YJmt1JN/Om875PAR8G8cp6YUSJo6khN6XG7ynJUU3ZCDTSVpZ5F9B8eBMwfeR2B7
	/rWgdfR7wgDPzm9Xu74iJjRr0d9Ke0uRoLlT/WYOloRAIJElxUc3ZgFtBVJdUk8G
	YloFwqB+ABfiFWHoMMUosPhybj2onzvgmCkHqEdzYJIXHwwQpLK8/joAaVXBf8u6
	UXsxFL4XHKZ+8UFoc8PJ4veSZrg5W9EqUhjTFweMjFIcAdetMXKP8WtRM1NTC6et
	MGXhKm2+cG6NpxxctrB8ZoKXP3jRwQG9+ehx3/IqP7N7dFSIXMENv577cuFe5HeN
	aBY6fIn7vXnxTrQKJw==
Received: from p1lg14880.it.hpe.com (p1lg14880.it.hpe.com [16.230.97.201])
	by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 4gaqe3bw9h-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 27 Aug 2026 20:03:34 +0000 (GMT)
Received: from p1wg14925.americas.hpqcorp.net (unknown [10.119.18.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by p1lg14880.it.hpe.com (Postfix) with ESMTPS id E1999800E8A;
	Thu, 27 Aug 2026 20:03:26 +0000 (UTC)
Received: from p1wg14928.americas.hpqcorp.net (10.119.18.116) by
 p1wg14925.americas.hpqcorp.net (10.119.18.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 27 Aug 2026 08:03:18 -1200
Received: from p1wg14927.americas.hpqcorp.net (10.119.18.117) by
 p1wg14928.americas.hpqcorp.net (10.119.18.116) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 27 Aug 2026 08:03:18 -1200
Received: from p1wg14920.americas.hpqcorp.net (16.230.19.123) by
 p1wg14927.americas.hpqcorp.net (10.119.18.117) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Thu, 27 Aug 2026 08:03:18 -1200
Received: from PH0PR07CU006.outbound.protection.outlook.com (192.58.206.38) by
 edge.it.hpe.com (16.230.19.123) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Thu, 27 Aug
 2026 08:03:18 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hVYLIYVP8aqgPj/5xPx/SRwAJv/c6ctRg3Sl7fCNdzK9TVgoWFFxQnYqaZug1RBU7beeaIFkFfPZ5hoY0A22HWCbWNjbXqt8nRMhd/g1xKs2BC8KA3sIoSRsfvJX3Kld80fjjluyydncccWrt078ke6UvmqZH09JzCseFv448Nj0dmCCsJXTYU8BnctASWSnKSws85q5Bdu+bW41umGbcYdtNV2J6POEnPqzfPRp7r2dYfvNKBe6QZ5dWi73QXCmRNV8vGR7GDjNhGvpkA3+3hV+yc5m8zdT44Xoqg8UsfxzucXvywDK47m+d4ysIj9+LAx4YLnlEJgoELheC6lNuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XM6x+nP1uziASf1+U2y8dPMk656jNzweBBEIJZaRP24=;
 b=eplwIGfLuXxxu033wfdPwhoMUk9V9jraqQbZ1AVJDXIEqQVDIQmsxEYrWT9GUDz9Sjazpw4jimAl/NaccBfh/U36eyUupUhjWsICdwx5hYNBO+x/SIF2qFmjKrH92blhH45lQn3N1T3Key6540GxhQWiMXPC9w1X/GKXhtnQIJS+ECHOeyA/jWnsqJJQw/32dPzae0jmTYoRqg6Rp5oMHjEl9T0J9mLTsMXg5LaMpRhXc0i19vzn1Ezjlug6wEyLsn+7B0435IPCUSishA9efYgfmZBWzN+i5GbAPg07HgOf3UsrLO3RYNw8XD94w7QHvUZUSa479vyWQVTeeeqstA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from PH7PR84MB1654.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:510:151::10)
 by SJ0PR84MB1846.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:a03:434::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Thu, 27 Aug
 2026 20:03:16 +0000
Received: from PH7PR84MB1654.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::92d8:a8cd:8cda:27c2]) by PH7PR84MB1654.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::92d8:a8cd:8cda:27c2%5]) with mapi id 15.21.0360.008; Thu, 27 Aug 2026
 20:03:16 +0000
From: "Singh, Jashandeep" <jashandeep.singh@hpe.com>
To: Mimi Zohar <zohar@linux.ibm.com>
CC: Roberto Sassu <roberto.sassu@huaweicloud.com>,
        Roberto Sassu
	<roberto.sassu@huawei.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        "Eric Snowberg" <eric.snowberg@oracle.com>,
        "linux-integrity@vger.kernel.org"
	<linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org"
	<linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        Jashandeep Singh <jdsw@juniper.net>,
        "Garimella, Siva" <venkata-siva.garimella@hpe.com>,
        "Kumar, Kamlesh"
	<kamlesh.kumar@hpe.com>
Subject: Re: [PATCH] ima: select the SHA384 PCR bank for the boot aggregate
Thread-Topic: [PATCH] ima: select the SHA384 PCR bank for the boot aggregate
Thread-Index: AQHdNY6y/d21skUpKUejohSnWuMY6Law1nIAgAASUFOAAA1cgIAA64GAgAAY1QCAAAL0AIAADtsAgABGxIA=
Date: Thu, 27 Aug 2026 20:03:16 +0000
Message-ID: <F9EB24A1-B4B1-43AC-9A35-C947CFE21AA3@hpe.com>
References: <20260826191051.219090-1-jashandeep.singh@hpe.com>
 <4ea0433a82c219d6efdb83ad0bf267045c91a374.camel@linux.ibm.com>
 <PH7PR84MB16549E7A6AC842D358493B0F96AE2@PH7PR84MB1654.NAMPRD84.PROD.OUTLOOK.COM>
 <21bf74a181df485f9daf47f9740972443e31471d.camel@linux.ibm.com>
 <92bf67810c6ed6bc4764f330d77c3ac2279781eb.camel@huaweicloud.com>
 <037C125E-9343-464E-A1AF-8078D3B7BA38@hpe.com>
 <d63a007c6d371496780d3577e64e57b4d0e11e1a.camel@huaweicloud.com>
 <837c208460cd7dae1259bd3fd7b8f176ab3597ba.camel@linux.ibm.com>
In-Reply-To: <837c208460cd7dae1259bd3fd7b8f176ab3597ba.camel@linux.ibm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR84MB1654:EE_|SJ0PR84MB1846:EE_
x-ms-office365-filtering-correlation-id: 8f887aff-2470-4f2a-b924-08df04763b95
x-ld-processed: 105b2061-b669-4b31-92ac-24d304d195dc,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|10067099003|56012099006|6133799003|4143699003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: JHP+9ISplu4OtTx5Ds9hOjO3e24oiUotwyK+pE9+Z/X2bLvL1W9yKACdI1rBv+lYBX0mUDrWavxd6XgcmRCRlnPlDepS+PvWO2qTvt/54/tyi7nB832ezCFaw9eT5Hb/+Csky2c7zN2yDRq2zDTxV63toirxD6O88DGCCqE4wCE1SWtjTLeE9tApGysSC9Y0oJrBPCj5kpv0h45xQm0c2/8n/BEVCa99oZZMeC89k1pH8Fvtk/o4LrqVnErGH7RiEk9I1jzHCv8euzkaPOjGfCTemFzfAyQUOW/AmCJyy6u1MAcUcZU3q9XY6ilvAKkfURgJqYKQt79ZwlBSwwU8wtyBrmHQJRGQ3JUCsFP9Ub+6sRrf8F+FQw5p25F5foN70QtJDUKqdzYOI71I6Uo58c2JgUqGl3mu86IXaQj+KFdcn4Ucq1szszEzaVd7FfSxeKuAJ1oQ8proxfuIVH09JMT2CgS1wXYuGZ8hpvqtpEGBkjnAnbeVx3si4qehA56SNXXXBw4cKRK9sBPqLRuCPf0ebRMnMhl5iLWU+yRUTlZ5HAe2OMW+ih6k4XXOBO0+6z1dLqKrI9WdXEYdwrb4ZrnO9ZryK8qwKut4TCwtW2muoLtWuzLUa4QLMh6Lc6bMvfP2Hi+F5nk6o/Hzb6DM2Ri/Zv8a4+OOcViFwERv0XfqUJMMW56dYcJ8Q0wvMV93Xilxj9mJYL28IE8s4ujhB5GUO4ZYkTqpAytTdXjQ2GU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR84MB1654.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(10067099003)(56012099006)(6133799003)(4143699003)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L0dmNFo0UmlDdjJKWGJlUEgvTHp5bHhxZ0tyOS90N1IzbTg1Tk5sZDEwV1Rt?=
 =?utf-8?B?L3ZpTisrRHNUUjNESXcvQ1JKUUcrdUhVVFB3YUlTeWtEK3F0QUZKa0pNUUxB?=
 =?utf-8?B?VEV4b2E5MXJ3UnZQSlFhYkR4Nko1Yy82RUVkWXRKREQ1Y2R2bDZpMGNVbDVi?=
 =?utf-8?B?bVNTOUZCT1pBRzZiWDc3UU5HdVNJdFZxVHZ5d0IrbHRYaC9jQnBScGtiTE9D?=
 =?utf-8?B?c1ZYOThHZ3hxQnpyWHMrZzRiMmFmRTl2TWlQT29kenpYMkdPUnhKQXJpek1J?=
 =?utf-8?B?TmlLRGxUVTZOUGg2RXJVU2loVlFheHFlTmZhbE50RENoTkJERksrbk9UNlZJ?=
 =?utf-8?B?MDhsWUdNTzJrTVZYcUdQMndNL21BTWhDZFRuUGZDVERQaytlcGpudjFkbm5Q?=
 =?utf-8?B?K2F2UTA4RTZDVzZqb2FZN0hmcUk0MXVzWjE2ZjFCS1BOT01vNThaSi9tWDlY?=
 =?utf-8?B?T2xGaWE1WDBpKzRacmlMbk1aWGkvdXB4czNFUTNjeUNZN3lySnFDR256Tjhr?=
 =?utf-8?B?UkprM2kvWXcxN296c25YNDM2cDNMSlU0UUFxcGNWdDRxSUc2aTNMTDF2Tkpu?=
 =?utf-8?B?MUl3QzdhRVptbmQzTnAydEFsUFJOL3NRUTFGU2RMaGw2MXJkUTZaSHlHeHdN?=
 =?utf-8?B?STgzL0NoZTdpUlczQ1NZL0YvRmJENUNVanJlUmN2K0lydEZjM2ZsODV2Smov?=
 =?utf-8?B?Rk1zVlFzRDBBUUhmbzVQN0RCZ3k3cjY1cndZVmthaXdiN1F4MWphVVNMdzFJ?=
 =?utf-8?B?dW9uZDVBQWxqUEZWVzUrNTBycit6ZytyaHFoakUzMGdGU0ZDcUlxK2ZHK2pB?=
 =?utf-8?B?bEVwSEJId2lTUXpGclFJTFM3M0VnZlVTRExBYVJUWmt3Z2NqWjBxSVl0L2I5?=
 =?utf-8?B?VERpUXNjUVZTRmo2Zy9wOUlnRUthSHl5RDdOY1RLMFBTdHdRSVh3Uk0xVS96?=
 =?utf-8?B?dkJ6dkpSdzVaM201VEYxd2ZLTVgrTlF5MmVtSnBnTU5ZSkhxb29kd1UzWmRk?=
 =?utf-8?B?WWJ6TVNNU1IxUlFYWENSZFFJTXpENFo3ckF6QTRydUxwRTVQeitqVTIrMVN3?=
 =?utf-8?B?ZUR0ZEx0c2ZnNkJ2UEd5SmVLcHhDcC9VejZWMEdmbmxqa3NHdnRwVUJlQXZE?=
 =?utf-8?B?RWtwMStLelBkZ1h5dFNMc0JFNjN4Q2p2aGpHaHdHWGh6OWQ3cE5wbWlZSzhz?=
 =?utf-8?B?SGZsZzdiemZ0Vll2ZmVWQ0YwWWxFR2F3TUU2OXVnR3ZjQWZIeXNUdHNWdjRO?=
 =?utf-8?B?NFdxTTcwQk0vOUlqRzIxdHlDNUIyRkJjbnJUMjNwK2dEeThkMW1RL3N3LzBO?=
 =?utf-8?B?aUQzcU9oV3Y4Y3Qrb0xqeGk0aVFkM0pyMEdQNzRuMjg0VjhtVlZ0RjJGcnlY?=
 =?utf-8?B?WE9oNWk5bWpEZE1oNCtwazN1emJJTGMwcHhWTXpkYVVYZ1BlUHAxR25adENT?=
 =?utf-8?B?SlkrckVHOFZueUphcjVzTVlJeXJhbGNkZUM1N2FldWhHSHZuSXVnN0NVbWh2?=
 =?utf-8?B?RjBlUGI4cFlZdHRnekgwUmNOMEQwTTRBQWcyY2pndzhwVmVZZ0lkck9RVSt1?=
 =?utf-8?B?RExJYmZUYlBFNUpGNXVtL1M3UFpMaHJzYks5ajlnRVpyZUl2eXBCa1IzUzd0?=
 =?utf-8?B?a2FLejRUbkF6WERvRXRjNmEyalA0Y01leXRub0dDYi9UWG5NeVVaU0hxb0Zv?=
 =?utf-8?B?UUlNMkI1ZHY5djdDQTR2elBnU2JoT2hrWjhSb084eEIvTU1hNDN6QWlOQSt1?=
 =?utf-8?B?Zi9SOXVnczhXN0t4VjdCK00rNW1uSUZPZmhLa01YOTR1QmNqSHRrVzdRVXA4?=
 =?utf-8?B?MmdsUDZPM2sxdEhSWkVJaktBditrVzNpeHVHUWJEL29RQUVtcGRqTExnUmdW?=
 =?utf-8?B?amVIeW5TdG5KekxjakVreS9xWk5yWjczVkFWci9UR3FrbU9GVnJtVVYxUjJN?=
 =?utf-8?B?UW9BeWtmeVU4Ty82YmNyQUd6RlNXajllUTRYSkpCTGxTVk90anVFb0FzejNn?=
 =?utf-8?B?cTczbEw4blNUU1hDaThHR3ErRXVURVA5dGNRdWd1MWoyaDROSXNEaEdEOVJE?=
 =?utf-8?B?N3hlTmFVTUl6M3p0Z0w2ZDhwckxZODBOVUtIZ2pEWnpaOEppb2FRb3ZDKzAz?=
 =?utf-8?B?OFZOdkRsaVNUZ3ZPTVFPZlBRWTBEY3JCLzJydkY2UkpiZHlPbUpzMit4WjNh?=
 =?utf-8?B?ckp5NURhbCtsc3NEMUkwb2dCSUQwZ2dqZWVWbFQvMndPWDlPcXlxZjRkR25M?=
 =?utf-8?B?MTk1enNvRzVRUFAvUTAwcVB5UWhmYTZmQmtZajlYQUx5VFJXOEwySjVGOTFS?=
 =?utf-8?B?UW1FV0RLQUl2ck41QjAybE1qNldYWjkxdnZnYTBzeUJVemFtUTRaeXNSU1NO?=
 =?utf-8?Q?f5SV9SdQ2Pdffg+0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E5B48E1E770D4540AF03F84DF8757E79@NAMPRD84.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: vq0s58kVeby1acJWbjTzTVYlvMJLVlXQYDs/iyguSRHJHiZ9LK+r/3NWJSydomwyRKLTheVb55hIEpgnH4rf42XGTDAvGGmU19OahkumRo3akxzAeknnkc1BzV4x6r27dUvp9xh5jgKTrC4nAbk0qc+6xvgsDVKcCgQbouLx6zQ/sBCEdBf/Qn4YXam9eTcOyzCVa1JuQMe/L6p1MnfYhQnEXFi3tUYfaPWOsEkC2cihi+Kzt4DWEG2VNzVys0YWSz6e939jgBCzDQYzjKkx/z3KFZ7cCHGrQm8+r+2v2KDC/OEXavLWLxzfrJM4zQtWKs443eNj9V4dmEmLyUhQkQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR84MB1654.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f887aff-2470-4f2a-b924-08df04763b95
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2026 20:03:16.2155
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /E6UhWVtb12f9kn6J2oR9OEJF+/0tnFTNWAprpOfiHumflRoUu9BJpSsi/EhaIqpw7jvy81eJgWSLzM3ADjMD1Htm94fXx0sOqUsOaoHj7c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR84MB1846
X-OriginatorOrg: hpe.com
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: 88wuVOsYeUV6-wufFpjYbJs3FPjUhlbU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDE2OSBTYWx0ZWRfXzEen1EYPcDOM
 exqOKkXiiF6Me7HyyToc8DgmF+HZA21e+AGdSIKkO8YpHasI/BwntfZVWLCx415j2tGQJpGrq3S
 5n4GurcSs8ZWErIOuqiv1BDiYhreW5E2dEGv7L5aKILd0SK1Lj3SCh6+IEF1yJ/sgMKBfLff6zn
 Uk2uvC33Bw1D1Jki9rBKo0Vjn1hZjKFp0+Xmpsh4kdnPzqjikJ1hWutr41J0kofZnPhuCAkpHiV
 Q/mVb+UkpipU2ffywQjuu9JHvuh0KwEMYxiIg0cyF/VZsFVRDwHk5M5qBBKl+vNo4y2kiIr7Wn7
 8FKJ4yVpODltWA7LQkDcxKo1qqVFlmpWy/IkregHJMvs4N1JBCOZdF+8nHJGbEP42uyveMc9/ow
 f2Nx6hEdO0w2zYENlPxRA9Y6K1Bxcj9okWld3OX4jmTI23pigE3CfuACk+qGNL+Cx+Glsn1XCdP
 Kq+Q1HetF5oMwNMKjhg==
X-Proofpoint-ORIG-GUID: mo9Ti8IupX0jXpmRNyV2jk8_VdbBF-Yo
X-Authority-Analysis: v=2.4 cv=HeMkiCE8 c=1 sm=1 tr=0 ts=6a909817 cx=c_pps
 a=A+SOMQ4XYIH4HgQ50p3F5Q==:117 a=A+SOMQ4XYIH4HgQ50p3F5Q==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=gQcMVamqm3wCPoSYhaRC:22 a=J0OTuHAx6l5K1fCpvPfz:22
 a=VnNF1IyMAAAA:8 a=SGFPTKBUyTrMv-RHp64A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDE2OSBTYWx0ZWRfXzU7hDCxhu1nU
 vR1vDJUanclOEmlORyGwWxUn6trq1YO9qjHy9DIqjVD71oKrgSC2pkSlKAhvTz7njp0FSQmuLGN
 qldeQnz1dABP3H21JO2Atx+Xysq4HcM=
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_08,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 clxscore=1015
 malwarescore=0 impostorscore=0 bulkscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608270169

VGhhbmtzLCBNaW1pIGFuZCBSb2JlcnRvLg0KDQpJIHdpbGwgZXhwbG9yZSB0aGlzIGFwcHJvYWNo
IGFuZCBzaGFyZSB0aGUgdXBkYXRlZCBwYXRjaC4NCg0KUmVnYXJkcywNCkphc2hhbg0KDQo+IE9u
IDI3IEF1ZyAyMDI2LCBhdCA5OjE54oCvUE0sIE1pbWkgWm9oYXIgPHpvaGFyQGxpbnV4LmlibS5j
b20+IHdyb3RlOg0KPiANCj4gT24gVGh1LCAyMDI2LTA4LTI3IGF0IDE2OjU2ICswMjAwLCBSb2Jl
cnRvIFNhc3N1IHdyb3RlOg0KPj4gT24gVGh1LCAyMDI2LTA4LTI3IGF0IDE0OjQ2ICswMDAwLCBT
aW5naCwgSmFzaGFuZGVlcCB3cm90ZToNCj4+PiBNaW1pLCB0aGUgcGF0Y2ggY292ZXJzIHRoZSBj
YXNlIHdoZXJlIHRoZSBUUE0gaXMgcHJvdmlzaW9uZWQgd2l0aCBhIHNpbmdsZSBQQ1INCj4+PiBi
YW5rLCBTSEEtMzg0LCB3aGlsZSB0aGUgZGVmYXVsdCBJTUEgaGFzaCBpcyBjb25maWd1cmVkIGFz
IFNIQS0yNTYuDQo+Pj4gDQo+Pj4gVGhlIFNIQS0zODQgYmFuayBpcyBwcmVzZW50IGluIG5yX2Fs
bG9jYXRlZF9iYW5rcywgYnV0IGl0IG1hdGNoZXMgbmVpdGhlciB0aGUNCj4+PiBjb25maWd1cmVk
IGRlZmF1bHQgKFNIQS0yNTYpIG5vciB0aGUgY3VycmVudCBoYXJkY29kZWQgZmFsbGJhY2tzIChT
SEEtMjU2LCB0aGVuDQo+Pj4gU0hBLTEpLiBBcyBhIHJlc3VsdCwgYmFua19pZHggcmVtYWlucyAt
MSwgYW5kIHdlIGhpdCAiTm8gc3VpdGFibGUgVFBNIGFsZ29yaXRobQ0KPj4+IGZvciBib290IGFn
Z3JlZ2F0ZSIsIGxlYXZpbmcgdGhlIGJvb3QgYWdncmVnYXRlIHplcm9lZC4NCj4+PiANCj4+PiBS
b2JlcnRvLCBpdCBpcyBub3Qgc3RyaWN0bHkgdHJ1ZSB0aGF0IHRoZSBib290IGFnZ3JlZ2F0ZSBh
bGdvcml0aG0gaXMgYWx3YXlzIHRoZQ0KPj4+IHNhbWUgYXMgdGhlIGRlZmF1bHQgSU1BIGhhc2gg
YWxnb3JpdGhtLg0KPj4+IA0KPj4+IFdoZW4gdGhlIGJhbmsgY29ycmVzcG9uZGluZyB0byB0aGUg
ZGVmYXVsdCBoYXNoIGlzIG5vdCBhbGxvY2F0ZWQsIHRoZSBleGlzdGluZw0KPj4+IFNIQS0yNTYv
U0hBLTEgZmFsbGJhY2sgbG9naWMgc2VsZWN0cyBhIGRpZmZlcmVudCBiYW5rIHRoYW4gdGhlIGRl
ZmF1bHQuDQo+Pj4gVGhlcmVmb3JlLCB0aGUgYm9vdCBhZ2dyZWdhdGUgY2FuIGFscmVhZHkgdXNl
IGEgZGlmZmVyZW50IGFsZ29yaXRobSBmcm9tIHRoZQ0KPj4+IGNvbmZpZ3VyZWQgSU1BIGhhc2gu
DQo+Pj4gDQo+Pj4gTXkgcGF0Y2ggYWRkcyBTSEEtMzg0IGFzIG9uZSBtb3JlIGZhbGxiYWNrIGZv
ciB0aGUgY2FzZSB3aGVyZSBTSEEtMzg0IGlzIHRoZQ0KPj4+IG9ubHkgYWxsb2NhdGVkIGJhbmsu
IFRoaXMgYWxsb3dzIHVzZXJzIHdpdGggc3VjaCBhIGNvbmZpZ3VyYXRpb24gdG8gaGF2ZSB0aGUN
Cj4+PiBib290IGFnZ3JlZ2F0ZSBjb21wdXRlZCwgd2l0aG91dCByZXF1aXJpbmcgdGhlbSB0byBj
aGFuZ2UgdGhlaXIgZGVmYXVsdCBJTUENCj4+PiBoYXNoIHRvIFNIQS0zODQuDQo+PiANCj4+IFRo
YXQgd291bGQgd29yayBmb3IgeW91ciB1c2UgY2FzZSwgYnV0IHdoYXQgYWJvdXQgYW55b25lIHVz
aW5nIGEgc2luZ2xlDQo+PiBTSEEtNTEyIFBDUiBiYW5rPw0KPj4gDQo+PiBXb3VsZCBpdCBiZSBm
aW5lIHRvIGFkZCBhIG5ldyBLY29uZmlnIGFuZCBrZXJuZWwgb3B0aW9uIHRvIHNwZWNpZnkgYQ0K
Pj4gY3VzdG9tIGJvb3QgYWdncmVnYXRlIGFsZ29yaXRobT8NCj4gDQo+IFllcywgSSdtIGZpbmUg
d2l0aCBkZWZpbmluZyBhIG5ldyBLY29uZmlnIGFuZCBrZXJuZWwgb3B0aW9uLiAgDQo+IA0KPiBF
eGFtcGxlczoNCj4gc2hhMzg0OiA8ZGlnZXN0PiBib290X2FnZ3JlZ2F0ZSwgd2hlcmUgdGhlIGRp
Z2VzdCBpcyBjYWxjdWxhdGVkIGJhc2VkIG9uIHRoZSBUUE0NCj4gMzg0IGJhbmsgUENScy4NCj4g
DQo+IHNoYTUxMjogPGRpZ2VzdD4gYm9vdF9hZ2dyZWdhdGUsIHdoZXJlIHRoZSBkaWdlc3QgaXMg
Y2FsY3VsYXRlZCBiYXNlZCBvbiB0aGUgVFBNDQo+IDUxMiBiYW5rIFBDUnMuDQo+IA0KPiBNaW1p
DQoNCg0K
