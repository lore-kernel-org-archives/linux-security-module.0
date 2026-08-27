Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB6D47FAE3;
	Thu, 27 Aug 2026 14:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.147.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787842034; cv=fail; b=BX8QVfKVBD7JeVfisrAyIXdu9aURCXyG9J7uQ80FQ6eNhxX2Ja6RCkmZhuOQsV+1M+VJLYJKlRK+8rMCd9bOXgV1RZO2BfAEp86COTpQrHf8c4h+fkAWKvs80NW2lnkikIflPfFptsSZUsjVj2sqDikuGXGzEvUlF10RFVlBqJ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787842034; c=relaxed/simple;
	bh=Lz8axksbu04FuG2Ulauhlq1wY0+my/7VwD0rnWbClpo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=O/0gqiNpx3KA/sabeLnELVCBoLer9FhHmio2WNWHdCtaDIf9SiUoK7oVFkdE3vwMX8dliUhT8lLCu6cO6pm39bpFFjkKyb0T4bh7jNmBdW9QjksEX4Uv39DdbalocFpkruA6w40Cvuk+MDRvN3gKfAwRyKHhtQ9m+E1/khAunfA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=kVYySaWi; arc=fail smtp.client-ip=148.163.147.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="kVYySaWi"
Received: from pps.filterd (m0148663.ppops.net [127.0.0.1])
	by mx0a-002e3701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67REDZKT2636829;
	Thu, 27 Aug 2026 14:46:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pps0720; bh=Lz8axksbu04FuG2Ulauhlq1wY0+my/7VwD0rnWbClpo=; b=kVYy
	SaWi8PybUCmp+Lf3VGEGsDCWlQP6AC3fLLU//d6OUkRkl8w0ayCgg1REWMN8RrUd
	PyNPrHmKjGnmV5t9csZdW9NceC1nf6zpefnATAG0bjA4YSuMoQ+K95F9rbqTTq5F
	U1lQd9O/iXhx1SYH058Ik8zB+2Pa7nehyzgj1G5hNrSI3LlAL6Y9QLioHfYxCMj4
	TA4L45vxLTpdvUNBJ9Vv/KRMSlf53wHcLkOg86Dh5sAgX/y2SrCpPhVxRIjyOkwb
	4u8ixBlR2xO+P2U1uXLqrfKVlLwczBb+e/uJqoW6CKVC1L7LpkSOrM+0SgTz0oc2
	p0sFbu6zr+VZUojCTg==
Received: from p1lg14881.it.hpe.com (p1lg14881.it.hpe.com [16.230.97.202])
	by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 4ganwjs9s7-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 27 Aug 2026 14:46:28 +0000 (GMT)
Received: from p1wg14924.americas.hpqcorp.net (unknown [10.119.18.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by p1lg14881.it.hpe.com (Postfix) with ESMTPS id A91D4806B10;
	Thu, 27 Aug 2026 14:46:27 +0000 (UTC)
Received: from p1wg14927.americas.hpqcorp.net (10.119.18.117) by
 p1wg14924.americas.hpqcorp.net (10.119.18.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 27 Aug 2026 02:46:20 -1200
Received: from P1WG14918.americas.hpqcorp.net (16.230.19.121) by
 p1wg14927.americas.hpqcorp.net (10.119.18.117) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Thu, 27 Aug 2026 02:46:20 -1200
Received: from SN1PR07CU001.outbound.protection.outlook.com (192.58.206.38) by
 edge.it.hpe.com (16.230.19.121) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Thu, 27 Aug
 2026 14:46:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vZe3CHN4oB9ZpB2OQZdu/89wIsWFCLxB2FvabwacKotN/SFHcQ2rmjS5Izp5tnUs9WeShcxkhPjHZIPqKjWHoL5LMWG19GCLJICwmBusoLOlSCMW3d63RVDMpa3LTPbIuekdG1aI+dUQ/K5YeJigQYL3MpRmuycPqh9RWCG4KFIqg/6sLXFxddoEBRj4hs6nXU3VM7TiAZ4uNHMyAp7YEDWVJyO7IhCS/AH+SPUNs7yPGrTpPZvUExSLoCaXnJWSsggoW/E7CV6iJy7hJWhlvd12XNYVaskrYrqOPf/OXTpILDVm23QIWTPWSKv8Boz14fCW3821iq3LUP4nPS04BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lz8axksbu04FuG2Ulauhlq1wY0+my/7VwD0rnWbClpo=;
 b=oNgAp0lAX3BFmxLHiqlRYawl2+zwmRk5lnx4We1eTb2Wf/gutgtXFtQXHmEiQnF2XbgZwF5GuY+yrfT35yAgnkbxcJ0DHIgFqruJYkZj+k/qPkRfG0wmWmMZ8l0eyvfKEaVCUee5eDvUyIarGnqMF//gLDa4Ua6/FQk32xMi6KLXsJY//ye3ekttKgODGHInwSln3lXpgaB7NQkw1Fh9tCBGmyKlL0pS9lVxPS1cJcobjrAnnO4l413ibfg7Hc5mJoQL7+1wvTN6I3BdsY18EWsBzai609b1ceBUTUKuZ1Edrt4Ew3z9UWUoLGvX93+V+reWxgAsRhO/t0f19NyoFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from PH7PR84MB1654.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:510:151::10)
 by SJ0PR84MB3223.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:a03:44b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Thu, 27 Aug
 2026 14:46:14 +0000
Received: from PH7PR84MB1654.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::92d8:a8cd:8cda:27c2]) by PH7PR84MB1654.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::92d8:a8cd:8cda:27c2%5]) with mapi id 15.21.0360.008; Thu, 27 Aug 2026
 14:46:14 +0000
From: "Singh, Jashandeep" <jashandeep.singh@hpe.com>
To: Roberto Sassu <roberto.sassu@huaweicloud.com>
CC: Mimi Zohar <zohar@linux.ibm.com>,
        Roberto Sassu
	<roberto.sassu@huawei.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Eric
 Snowberg <eric.snowberg@oracle.com>,
        "linux-integrity@vger.kernel.org"
	<linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org"
	<linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        Jashandeep Singh <jdsw@juniper.net>
Subject: Re: [PATCH] ima: select the SHA384 PCR bank for the boot aggregate
Thread-Topic: [PATCH] ima: select the SHA384 PCR bank for the boot aggregate
Thread-Index: AQHdNY6y/d21skUpKUejohSnWuMY6Law1nIAgAASUFOAAA1cgIAA64GAgAAY1QA=
Date: Thu, 27 Aug 2026 14:46:14 +0000
Message-ID: <037C125E-9343-464E-A1AF-8078D3B7BA38@hpe.com>
References: <20260826191051.219090-1-jashandeep.singh@hpe.com>
 <4ea0433a82c219d6efdb83ad0bf267045c91a374.camel@linux.ibm.com>
 <PH7PR84MB16549E7A6AC842D358493B0F96AE2@PH7PR84MB1654.NAMPRD84.PROD.OUTLOOK.COM>
 <21bf74a181df485f9daf47f9740972443e31471d.camel@linux.ibm.com>
 <92bf67810c6ed6bc4764f330d77c3ac2279781eb.camel@huaweicloud.com>
In-Reply-To: <92bf67810c6ed6bc4764f330d77c3ac2279781eb.camel@huaweicloud.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR84MB1654:EE_|SJ0PR84MB3223:EE_
x-ms-office365-filtering-correlation-id: 6403dd5c-5472-4149-4926-08df0449f1fa
x-ld-processed: 105b2061-b669-4b31-92ac-24d304d195dc,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|10067099003|6133799003|22082099003|18002099003|4143699003|56012099006|38070700021;
x-microsoft-antispam-message-info: +f5niWUvhf+z52lh1UseTOR0YVCvWlI6Ds2fa/ozGV9WGYN+84iTHoB5X2qE+AOzucbnCXYigD8h/tqMLhtIkc13uBfAKKVJfKwy4Le+XsKM1xyReJHkjQd5BoWLjjpM67XCjN2qSicdKjtdnBXGYANGVeb2N1p8ZLoesamsYQVKTw9WsyHBVFIWYIhVyK4fospkXs0SlYmPIwo5/PCHnFq7w0x2TLb3uUddluTun9A47bqGnepPgv3XhOKXRVVYriHzDr+7fc2V7Be/VmlJjqaVkH/OoUMrq7OxRa8hVIteAUeUylYSu4Gtfqa7Tkssovs76pK+sULGcVEpcm0Bv+IznjesjraqK4kZcy/AIzOuDpXFEhGdeu9haFzksdYIgvAgawFTWGUqVmESDxMS8NTo6ZYEfcwzaBnNC591O9h44ofu0MvGwoM10A6CdyZuFDT4P5DYK5c9LzT70wPlhF320qIp9MnvvEpymisXVCH+suaXWLqaS5KJTL5+x7gJAHWLuUwsXc1wabIvqo4SF1oGl0Q8l88LUyxI++2U3NvpS9bBdcX/chSZMEozKW/KC/OBiWEeFlghsDEGTXF7AZs3uf9vARdhYzsV6+U28FFnjhwXuI1Tir60NgalTsJnPKN3nDHnMm8ERjnUFahRONWiOSxPKckvoYJIiGX8V6wPjiW2psxwXxfh15KTjW8d
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR84MB1654.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(10067099003)(6133799003)(22082099003)(18002099003)(4143699003)(56012099006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VkhnSEJiaEVzaFBabDIzcWRYR08vMEpqUWVydUhCY09yNnkycEUrYUR1YjJl?=
 =?utf-8?B?dldvK0doVjh0dXUwWjlzbkNUNUJrYk94bHhCSjZ6VEw1cG15c0JDeGJSU2Zl?=
 =?utf-8?B?NUhVUFN4TWZBTElSQ3VIMXFxWWowUGlMWFRRbHZIRG1qTG1MQ0MyMWRTQk1U?=
 =?utf-8?B?ZGRIOXJsVVZ5b0xaYlcweWRKUXZkWVIxVGFraTdYZ3lzT2NySVEzalNWeFNJ?=
 =?utf-8?B?ZW5qN0ZQdXViVjRscHordS9LbklUV0pDSFF4VTBRZFQrRGN2WnZBWFNJajZG?=
 =?utf-8?B?WmVQUFRvSFlTL0RKbHFYaXNtTCs2bVZ4Q25Pa1VzWGZsZ1dHRHBiR2tVZ3pH?=
 =?utf-8?B?cEFBZ29xQ0hHT0N5RmwzZzRSdnNCZTRlMWIxRGNOd0w3V0liSFdValFpb0lz?=
 =?utf-8?B?bHp4ckpDWCtVQTJESlVVT29mcXVzTnY2dG00RTdIeFg2bHFNcGd6ZDlXOHlj?=
 =?utf-8?B?ZnlSTzJuRXFzbzJicHJTNHQvREdQZjBoYnUzS3o5L2pOYkVERjJVUk1NMjVr?=
 =?utf-8?B?Q045M2NIMTd5Tm5JWUs0NjF0dVlDdWFaUng5L2JkR0U2TlllaXdnaHh6UXlj?=
 =?utf-8?B?Um5qUmNDYTB0QlVmQUlvd3ZzV2xqWkJzQjNhZ1FqRm1oV3lOem5xb0dCa1ht?=
 =?utf-8?B?eUJ0bVI5R2s5czBEK2tqRXRPY0NGUis4TDRRTHhuZzFpdkxCVEE5ZTdPdWZa?=
 =?utf-8?B?S2NNVlBneVhWYXVEL1Rab1dlUXRLYi9KMXo0ODAzbWt3dDE0WTNyWHlzOWFn?=
 =?utf-8?B?OEo1QWpNelhMQlgwK3ZmTUFrUjUvaTdxaDRPK0hLdE16NzU3TGR0eVJsK0FH?=
 =?utf-8?B?c25wR1EyU2tZMGUzbko2SFJSV28xQ3FXdGRDS1hKamhYZWMra2FQZmY3R1gw?=
 =?utf-8?B?elM4V3FZT05taGZaZkgyL2h1SjdKOXd5VmtCL2l5SVBHdy8xUDljSW9pYjF4?=
 =?utf-8?B?cHpvVmQwdXJ0MDhsUllHQ0E1RXp4YlFNcWRnbFZDMldvQUhJNFV3dktRZGM1?=
 =?utf-8?B?SWdvNXRVMzQySGpidEdVUW1Hd3Bvc1U2WjhiYVVYMmpnUFNSakZ3ZHFNYnNP?=
 =?utf-8?B?TjJzUmtIaHhQdjV5SjIvaXVGMDRUYmJBSGlyTGFZZ0hhNHRHWjBmOGhJOHgr?=
 =?utf-8?B?TmRiaG9VSDFVd0N4cE1MekhyL0pQQmVsdGVFdDlJVlRPdGVOYk1QMG50M2JG?=
 =?utf-8?B?K2tjS3kzWGN5MXRlbDU4OWtxZFdaK29peTBGSTVTNlZWendoc01mK1p2dmp1?=
 =?utf-8?B?aU45c1FveDNObng4UmZLenBlSTRBZnNJZnlpcEJza1NpYW9RV0JZQlo3d2Nt?=
 =?utf-8?B?TWpnSWVMcldqdXJqOHFRRkNNSms1VDAxd0ZyMGJTN0hUQ2swS2doKzNDbStm?=
 =?utf-8?B?S0RCbUZoUEhRSExRTEhhcFF4UTNiMlhGd1U1dk1XWHhMbElNZmlmdWxHNHZq?=
 =?utf-8?B?QjhjMDNIelRTQ3N3V1VXY3l0UDBnU25oamJxTTN3YmxvT2pnaE5oVG9oYnNC?=
 =?utf-8?B?V2ZkbnFIN0l5cjFTS1V4OFVranV0dVBPRXhKMzhtaEtCbHNuQ0pFeXBXYks0?=
 =?utf-8?B?WVYvRlBIQSsvclFKQW1FUkxiN0RFa29ZU2VmM2tTUU1hdkpLNlJ1ancxeEly?=
 =?utf-8?B?MmVsUHY5K2dXVkJ3ekQwSm13N2ZTd2hMSDBsWEg0SCtSVGh6Mk5ldEtnMlpB?=
 =?utf-8?B?ZENkd2tzVVNnTWVXL25Gc2J5YlU3ZkRFamtLeHJwTEJIWjF0ZUMzUnRETXRN?=
 =?utf-8?B?RTFUNjFWY3NPbTJuYStBQXBvWjNlQzBiUjJGMndENTErZzd0TlMzWnUxelVi?=
 =?utf-8?B?VUpzMnJUa1prZTVQOUU3aGtKSUh4M3pEb0NZOFpHbTExYVNyQ0k5MUpDSy94?=
 =?utf-8?B?QVl1bTNHem5Bb3p4eUp4elFhVVU2Ym54ZytnRVY5QXJHYW1pTG1xM0F2Y2F1?=
 =?utf-8?B?UEhpZzNBR25pU20vWWRvOW5aOFo3QXdyYjRaRUJmRXFyRHZLYkpxUGZObEtk?=
 =?utf-8?B?cHVZbzBvdkMwYzlFNkM2QkpzaU9SRFFZMHF3N0ZaNE1VeC8vL2Q3b0c2UkxZ?=
 =?utf-8?B?MTREaEVTbUM0Qm9IZTVMbEdZem9QTnc5bGQ0VEZvL0N0Q3laaUtaK3krQ3Rx?=
 =?utf-8?B?QmdkUHViY3J1S2lLMTdvcWgzQ2R4ZThpTVhNQ2pnUkVBVHJRSm1FaGE1Uzdq?=
 =?utf-8?B?TlUveElpTXdEbkd5cW5aL2ZJVHpKYTB4MC8wSGFwc1I0ZmNaNWY3TlFUT04z?=
 =?utf-8?B?VHhqL2Z6cDUyZWxBK3djTytZelltVTB5MGhnM1BiUXBNOVM0YjhRRmpub0NQ?=
 =?utf-8?B?OFlCSkpKMnJ2bTZDU216KzRSbjdJemFNYUlkZjZhQWpKSytiRm5DenZsK2Y4?=
 =?utf-8?Q?OyAMIkneXQgVBRLU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <32DAC48EA5C976429B7686CE9269EEE1@NAMPRD84.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: wPe8mbrWDzaEELFPfjiXgdSJaArpi9mwVawCWgs8zq5wFWBmiu3NV35dnQgEd8eLfBm91/5xnJLezjbUlkfEnXsVmczlunFRTo5QYqU6+drsKEVtsa/j0110dAXHFK5+t/lB9BBUYkhRNLNO/4YCgEpzvJ7KJNAXjtM8kObMXqy3bNYM/w58ePpxeh3QcppSPL3IUDu1GvY4aqs3OT4K9yTkNEiu1pySIs4QFE/1z/bfEBgXzPOU81O/Gve8mOYKKkUHOKOBDBlTlK+ua9qKe4euHKqnKLMhuQIRTEKFgGkYiKky98py6tjbgxI4vGcDnaomydT3IgfwSI9zKB1TCg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR84MB1654.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 6403dd5c-5472-4149-4926-08df0449f1fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2026 14:46:14.8095
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BXAa+6lyHctei2F+MKYt2/QQp415Gh8yvc87cdT1vFZeMLNyrAXCpamvGkvuLHiQI9JqOc6SNigrAuzq74nUnH2hq5rZ4qq/fJPLZC/5F9c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR84MB3223
X-OriginatorOrg: hpe.com
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDEyNCBTYWx0ZWRfX8jnvYywKFSPr
 PAB2Z88Mtsm3fzsIZsoFkU2LW/7hfHkuUQT4gkLT2wQvretujZOwULyzezOK7Fi3U/AaOTkCVCy
 3JT4GgE7OsKzrthDs2t72J8g0ylIu5Uc2CVJBiuB0ZRJ2QKDBffu1+Hlm37jBWvFgXzndEVhlWj
 /KBrQJBw9G4hjGV0sRan14uVw7FE5JiBqGYTJRy3eRN0Ukp90Nu3Ld0Qk8+mWjL9LFTJYvFa20e
 WyJMscgtvXsf7WsU329yuJx185c12vYdvJ8XoVxGRtoIvp/x8TGxMh64TcDKDreSz8GpBtWTKY2
 MRsHGaXK9M5w460PLmh/ciHwZWSsTUajtlaJ7yirvsxAbIwzximzXgF5V8rlzvnMEmgfFNjzudT
 z6PpT0ycVSvB98YIWxLkB/9aP8LlyV5ellstFzYiafV9hFKLddoUzQyI0CIWawCVuYqUGgUq/qx
 alOPUlYnFZZJbQQ4zbA==
X-Proofpoint-ORIG-GUID: nue4kQ78CNvlZlHU480b301yvw8TgRoy
X-Proofpoint-GUID: v76ZBxlf0isuiyp2wZSjpOqPXUk6EGxb
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDEyNCBTYWx0ZWRfX0lJwh9FjMWnQ
 DfK/xawtM4RNxx5I2RyI40cl004l9e5t0PeLTxbGl3UOR97GGCBT68cZv1Kjl0y8b+78Mr/hhDm
 iAzQjLTN9h8mWPYYO12ZnJKXrFdD4Vk=
X-Authority-Analysis: v=2.4 cv=YsE/gYYX c=1 sm=1 tr=0 ts=6a904dc4 cx=c_pps
 a=FAnPgvRYq/vnBSvlTDCQOQ==:117 a=FAnPgvRYq/vnBSvlTDCQOQ==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=gQcMVamqm3wCPoSYhaRC:22 a=6_mrDcixewTG61oOsKN3:22
 a=VwQbUJbxAAAA:8 a=AiHppB-aAAAA:8 a=cxG-8DlqCqNa4aaeGvIA:9 a=QEXdDO2ut3YA:10
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_05,2026-08-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 suspectscore=0 priorityscore=1501 adultscore=0 impostorscore=0
 phishscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270124

TWltaSwgdGhlIHBhdGNoIGNvdmVycyB0aGUgY2FzZSB3aGVyZSB0aGUgVFBNIGlzIHByb3Zpc2lv
bmVkIHdpdGggYSBzaW5nbGUgUENSDQpiYW5rLCBTSEEtMzg0LCB3aGlsZSB0aGUgZGVmYXVsdCBJ
TUEgaGFzaCBpcyBjb25maWd1cmVkIGFzIFNIQS0yNTYuDQoNClRoZSBTSEEtMzg0IGJhbmsgaXMg
cHJlc2VudCBpbiBucl9hbGxvY2F0ZWRfYmFua3MsIGJ1dCBpdCBtYXRjaGVzIG5laXRoZXIgdGhl
DQpjb25maWd1cmVkIGRlZmF1bHQgKFNIQS0yNTYpIG5vciB0aGUgY3VycmVudCBoYXJkY29kZWQg
ZmFsbGJhY2tzIChTSEEtMjU2LCB0aGVuDQpTSEEtMSkuIEFzIGEgcmVzdWx0LCBiYW5rX2lkeCBy
ZW1haW5zIC0xLCBhbmQgd2UgaGl0ICJObyBzdWl0YWJsZSBUUE0gYWxnb3JpdGhtDQpmb3IgYm9v
dCBhZ2dyZWdhdGUiLCBsZWF2aW5nIHRoZSBib290IGFnZ3JlZ2F0ZSB6ZXJvZWQuDQoNClJvYmVy
dG8sIGl0IGlzIG5vdCBzdHJpY3RseSB0cnVlIHRoYXQgdGhlIGJvb3QgYWdncmVnYXRlIGFsZ29y
aXRobSBpcyBhbHdheXMgdGhlDQpzYW1lIGFzIHRoZSBkZWZhdWx0IElNQSBoYXNoIGFsZ29yaXRo
bS4NCg0KV2hlbiB0aGUgYmFuayBjb3JyZXNwb25kaW5nIHRvIHRoZSBkZWZhdWx0IGhhc2ggaXMg
bm90IGFsbG9jYXRlZCwgdGhlIGV4aXN0aW5nDQpTSEEtMjU2L1NIQS0xIGZhbGxiYWNrIGxvZ2lj
IHNlbGVjdHMgYSBkaWZmZXJlbnQgYmFuayB0aGFuIHRoZSBkZWZhdWx0Lg0KVGhlcmVmb3JlLCB0
aGUgYm9vdCBhZ2dyZWdhdGUgY2FuIGFscmVhZHkgdXNlIGEgZGlmZmVyZW50IGFsZ29yaXRobSBm
cm9tIHRoZQ0KY29uZmlndXJlZCBJTUEgaGFzaC4NCg0KTXkgcGF0Y2ggYWRkcyBTSEEtMzg0IGFz
IG9uZSBtb3JlIGZhbGxiYWNrIGZvciB0aGUgY2FzZSB3aGVyZSBTSEEtMzg0IGlzIHRoZQ0Kb25s
eSBhbGxvY2F0ZWQgYmFuay4gVGhpcyBhbGxvd3MgdXNlcnMgd2l0aCBzdWNoIGEgY29uZmlndXJh
dGlvbiB0byBoYXZlIHRoZQ0KYm9vdCBhZ2dyZWdhdGUgY29tcHV0ZWQsIHdpdGhvdXQgcmVxdWly
aW5nIHRoZW0gdG8gY2hhbmdlIHRoZWlyIGRlZmF1bHQgSU1BDQpoYXNoIHRvIFNIQS0zODQuDQoN
ClRoYW5rcywNCkphc2hhbg0KDQo+IE9uIDI3IEF1ZyAyMDI2LCBhdCA2OjQ34oCvUE0sIFJvYmVy
dG8gU2Fzc3UgPHJvYmVydG8uc2Fzc3VAaHVhd2VpY2xvdWQuY29tPiB3cm90ZToNCj4gDQo+IE9u
IFdlZCwgMjAyNi0wOC0yNiBhdCAxOToxNCAtMDQwMCwgTWltaSBab2hhciB3cm90ZToNCj4+IEhp
IEphc2hhbiwNCj4+IA0KPj4gTWFpbCB0byB0aGUga2VybmVsIG1haWxpbmcgbGlzdHMgYXJlIGlu
IHBsYWluIHRleHQuIFBsZWFzZSByZWZlciB0bw0KPj4gaHR0cHM6Ly9kb2NzLmtlcm5lbC5vcmcv
cHJvY2Vzcy9zdWJtaXR0aW5nLXBhdGNoZXMuaHRtbCNuby1taW1lLW5vLWxpbmtzLW5vLWNvbXBy
ZXNzaW9uLW5vLWF0dGFjaG1lbnRzLWp1c3QtcGxhaW4tdGV4dCANCj4+IA0KPj4gT24gV2VkLCAy
MDI2LTA4LTI2IGF0IDIyOjM1ICswMDAwLCBTaW5naCwgSmFzaGFuZGVlcCB3cm90ZToNCj4+PiBU
aGFua3MgTWltaS4NCj4+PiANCj4+PiANCj4+PiBBZ3JlZWQgdGhhdCBhbGwgYWxsb2NhdGVkIGJh
bmtzIGFyZSBleHRlbmRlZCB2aWEgdHBtX3Bjcl9leHRlbmQoKSAtIGJ1dCB0aGF0J3MNCj4+PiB0
aGUgUENSLWV4dGVuZCAod3JpdGUpIHBhdGguIFRoZSBmYWlsdXJlIGlzIGluIGltYV9jYWxjX2Jv
b3RfYWdncmVnYXRlKCksIHdoaWNoDQo+Pj4gcmVhZHMgUENScyAwLTkgZnJvbSBhICpzaW5nbGUq
IHNlbGVjdGVkIGJhbmsuDQo+Pj4gDQo+Pj4gDQo+Pj4gVGhlIGlzc3VlIGlzIHRoYXQgYSBUUE0g
Y2FuIGJlIHByb3Zpc2lvbmVkIHdpdGggKm9ubHkqIHRoZSBTSEEtMzg0IGJhbmsgZW5hYmxlZCwN
Cj4+PiB3aGlsZSB0aGUgZGVmYXVsdCBJTUEgaGFzaCBhbGdvcml0aG0gaXMgU0hBLTI1Ni4gSW4g
dGhpcyBjb25maWd1cmF0aW9uLCB0aGUNCj4+PiBjdXJyZW50IHNlbGVjdGlvbiBsb2dpYyBvbmx5
IG1hdGNoZXMgdGhlIGNvbmZpZ3VyZWQgSU1BIGRlZmF1bHQsIHRoZW4gU0hBLTI1NiwNCj4+PiBh
bmQgdGhlbiBTSEEtMSAtIGl0IG5ldmVyIGNvbnNpZGVycyBTSEEtMzg0Lg0KPj4gDQo+PiBJdCdz
IHdhbGtpbmcgdGhlIGxpc3Qgb2YgYWxsb2NhdGVkIFRQTSBiYW5rcyBhbmQsIGlmIGFsbG9jYXRl
ZCwgc2V0cyBiYW5rX2lkeC4NCj4+IA0KPj4gICAgICAgIGZvciAoaSA9IDA7IGkgPCBpbWFfdHBt
X2NoaXAtPm5yX2FsbG9jYXRlZF9iYW5rczsgaSsrKSB7DQo+PiAgICAgICAgICAgICAgICBjcnlw
dG9faWQgPSBpbWFfdHBtX2NoaXAtPmFsbG9jYXRlZF9iYW5rc1tpXS5jcnlwdG9faWQ7DQo+PiAg
ICAgICAgICAgICAgICBpZiAoY3J5cHRvX2lkID09IGhhc2gtPmFsZ28pIHsNCj4+ICAgICAgICAg
ICAgICAgICAgICAgICAgYmFua19pZHggPSBpOw0KPj4gICAgICAgICAgICAgICAgICAgICAgICBi
cmVhazsNCj4+ICAgICAgICAgICAgICAgIH0NCj4+IA0KPj4gVGhlIHF1ZXN0aW9uIGlzIHdoeSBp
c24ndCB0aGUgc2hhMzg0IGJhbmsgZm91bmQgaW4gdGhlIGxpc3Qgb2YNCj4+IG5yX2FsbG9jYXRl
ZF9iYW5rcz8NCj4gDQo+IFRoZSBib290IGFnZ3JlZ2F0ZSBhbGdvcml0aG0gaXMgdGhlIHNhbWUg
YXMgdGhlIGRlZmF1bHQgaGFzaCBhbGdvcml0aG0uDQo+IA0KPiBQbGVhc2UgdHJ5IGltYV9oYXNo
PXNoYTM4NC4NCj4gDQo+IFRoYW5rcw0KPiANCj4gUm9iZXJ0bw0KPiANCj4+IE1pbWkNCj4+IA0K
Pj4+IA0KPj4+IEFkZGluZyBhIFNIQS0zODQgbWF0Y2ggYWxsb3dzIHRoZSBib290IGFnZ3JlZ2F0
ZSB0byBiZSBjb21wdXRlZCBjb3JyZWN0bHkNCj4+PiAoc2hhMzg0Oi4uLikgaW5zdGVhZCBvZiBy
ZXR1cm5pbmcgMCBhbmQgbG9nZ2luZyAiTm8gc3VpdGFibGUgVFBNIGFsZ29yaXRobSBmb3INCj4+
PiBib290IGFnZ3JlZ2F0ZSIuIFRoZSBmYWN0IHRoYXQgdGhlIFNIQS0zODQgYmFuayBjYW4gYmUg
c2VsZWN0ZWQgYW5kIHRoZSBib290DQo+Pj4gYWdncmVnYXRlIGNvbXB1dGVkIGFsc28gY29uZmly
bXMgdGhhdCB0aGUgU0hBLTM4NCBiYW5rIGlzIHJlY29nbml6ZWQgYW5kDQo+Pj4gYWxsb2NhdGVk
LCByYXRoZXIgdGhhbiBiZWluZyBtaXNzaW5nLg0KDQoNCg==
