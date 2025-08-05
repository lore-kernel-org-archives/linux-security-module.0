Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770D835959;
	Tue,  5 Aug 2025 22:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754432316; cv=fail; b=suvyGh+/AVLNlcvu8fBIdeYJG1N5Sk0AFCjLTiaEkMZIwOnqKbEVerYzpbda5pwVvf6rJ/yTRiiaiokE9imxqkAlpM4DF++9s7CSoakQDCAe0HRhFDhexv3c+tYnC40U5Yfb1jJWNLZD0GCtbwyjanJsP+9yVWafe5wONjjj5EY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754432316; c=relaxed/simple;
	bh=huXuj0w86lzZoOSB50I3mwNNvh7weTJcRjMEphJ3ju0=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=GHOvAP+O1brccenL/rTxmQc5C6SX1DIBMZYCn+UNpRFmIw0251WnY536Gu7itcOaOqMLjwXEy6ek2lO5JJ22UKcK43C6PHbZOuI1rMKBuFadKx02f+o6/IB7CFnOqpQh0yNwHcKqoEpR4JGCJrISUZfmFK4kUdGZ+DCKsX29FVo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TCGzfxTO; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TCGzfxTO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754432315; x=1785968315;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=huXuj0w86lzZoOSB50I3mwNNvh7weTJcRjMEphJ3ju0=;
  b=TCGzfxTOjca05Q3mil7KBUB4Cqm+psyDVidy9/Idmf33DhYQQlheZLsN
   +YAdF3AnJGhIcSdcDwb+1/usst1WSE2kl+meg7UB+UHYM9G7oX+b0JmQu
   jkJ1R+k2GdVeYO6kSxiwDp1SwpKGLABhQb8cokgqWEYcOPWcLwPbJyyCT
   iBhpqD5esMHopzR4V12YzWxHgqp7V3KDRAJEHpYRPL6rd8/wD7Z8Mnzby
   Th5kV3uWAxV9qIUThrZU/ZGd/EX7ck/HSB5Lr2tWl96znFx96kv4BHIZV
   Wxn/Iy1uOUehgenxjf/mQr8kWVzPasBqIKbFBke6EeVsofqtk1ekliT3r
   w==;
X-CSE-ConnectionGUID: mXqqzlBqRIqwGvGHfOG1ew==
X-CSE-MsgGUID: V0N50/5mSbSfNCRyvs1qnA==
X-IronPort-AV: E=McAfee;i="6800,10657,11513"; a="60572522"
X-IronPort-AV: E=Sophos;i="6.17,268,1747724400"; 
   d="scan'208";a="60572522"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2025 15:18:34 -0700
X-CSE-ConnectionGUID: W+BqjJpnR3aVsoED3SyyiQ==
X-CSE-MsgGUID: 3Sej271FQzu/vSjCJhAvEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,268,1747724400"; 
   d="scan'208";a="169876754"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2025 15:18:33 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 5 Aug 2025 15:18:32 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Tue, 5 Aug 2025 15:18:32 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.64) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 5 Aug 2025 15:18:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mj5GzbUlX8ulrNrc+6h1gVK8M6vVGCePUMknQxTLMGBw5ATjBJlTMetYkMJQ0ukTLX6Ir03Mb/WvWxHreDWpXLsvPuMC4qTcjqB/Bp1gmmGwJbAmZl1D4ap87w5VXpFzmNRu8MLr5Wx7ivS0Qnq4UZZ2dyKSYCIXWyQIGLQ23CcTRfFtdY91biSgxt8FC74Tiwi0AK1OMpGDVptLrlhE+9TMCjkMIyWuMiKOXi/lePHTS+MGv/TLo1uqMuzN1oO6rLSipRsrYgnMlSMlXKmDM/TpNMjReIDAMr6avXKVnx4FgW1UmbbTuf+U78mT5r3a/cthNIRMwVU5/E561PVIew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EguA7R6GdacbDcDV8u8iHPqL/Q/mZLLUVYux6jTMnLk=;
 b=mSV46MkP9l5mdfiHB6pOLamonry3JYnu6CTBIpe2xYMsCye/x5D9QQy6Sc68Ia8/qby3bToH1Kr6MzqjJ/bl4Srk+roW8Ustqx5t9+k3DUvEQS9283MbwpAuhfsA14eIwn/DMi9ao7QUsBrH8xX0Dtu3oh67KAf3On6ThFbyV9QIjjOtDPhOZnpEEfEFoJl8L+EyoB7iBBOeDV+zctlwVj51z6FI7cK+T4gcycZZoDprdjbNQewo2Jw37wu3IbWWeV48EQ2m44UaBtLHpQKSSVw91BjdOOIfa0JUAE3Yfmpr4Uu5P7+kTWBTmnQ70VAX/+mmo9Ky0S5vPz7IFruyhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA3PR11MB8118.namprd11.prod.outlook.com (2603:10b6:806:2f1::13)
 by CY8PR11MB6842.namprd11.prod.outlook.com (2603:10b6:930:61::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Tue, 5 Aug
 2025 22:18:15 +0000
Received: from SA3PR11MB8118.namprd11.prod.outlook.com
 ([fe80::c4e2:f07:bdaa:21ec]) by SA3PR11MB8118.namprd11.prod.outlook.com
 ([fe80::c4e2:f07:bdaa:21ec%4]) with mapi id 15.20.8989.018; Tue, 5 Aug 2025
 22:18:15 +0000
From: <dan.j.williams@intel.com>
Date: Tue, 5 Aug 2025 15:18:12 -0700
To: Nikolay Borisov <nik.borisov@suse.com>,
	<linux-security-module@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <paul@paul-moore.com>, <serge@hallyn.com>,
	<jmorris@namei.org>, <dan.j.williams@intel.com>, Nikolay Borisov
	<nik.borisov@suse.com>
Message-ID: <68928324c4a32_cff991002@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <20250728111517.134116-2-nik.borisov@suse.com>
References: <20250728111517.134116-1-nik.borisov@suse.com>
 <20250728111517.134116-2-nik.borisov@suse.com>
Subject: Re: [PATCH v2 1/3] lockdown: Switch implementation to using bitmap
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0103.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::44) To SA3PR11MB8118.namprd11.prod.outlook.com
 (2603:10b6:806:2f1::13)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR11MB8118:EE_|CY8PR11MB6842:EE_
X-MS-Office365-Filtering-Correlation-Id: fc1cd226-254f-47d1-b73e-08ddd46df8bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?N0JRem96TWNIMkVJeDNocW8xMVlEYThoeXNScmFpT0hKcFZyTXBsWlhienJh?=
 =?utf-8?B?Z0drNzUwR3FKb0Y1ZnJpVHdmb2tKbFdpZFRWSnpDMGlIMWZVckk2K1o0aHNt?=
 =?utf-8?B?V0ZPZmtGTkpsM1dFcy95Rm5nZ05xMXJFenRrOVpzQzg5N2NBWnVhR0JxVVc3?=
 =?utf-8?B?RWpVRTJoaVJzakJZdG9ST05STW0yTHUzOHRqZlhqalVGWHgxZERPZi9tNDdX?=
 =?utf-8?B?aU14L0RtcW1RRUtkaXQvcGMxUjE4d3JnTS9pR08zMjFUQnFZL1NQNUVOOFYw?=
 =?utf-8?B?T253YlB1b2lrQjRIRjlOV2RtQ0tPdm1QNWxTNzYrVXpuSjFiNjVNOW9YYzBH?=
 =?utf-8?B?Y1NtdUVwVXNDOHd3Q3Y5RnRXbDBBcW5rL1Y2UzJHeGViVFlkVkp0RXNBS0xD?=
 =?utf-8?B?TlNWa2dGT05Lbk02RXFkREhTMzNwQ2ZHNVhDb1MzVzZhMjNUM2M4SDc4eFI4?=
 =?utf-8?B?a0JGamNpU1ZMOG80b3NFVFZFUFVEOTJabnpRMkNUQ2l6dnFzZU9QaHVMeTF6?=
 =?utf-8?B?YUZUeE9saVo4K1VIa25FOTlRMGNzd1VnRWFjVmxvRUplVG41aWFoaHJIWVp3?=
 =?utf-8?B?OVpoQ2hLenl0dnJVVUlXOWhrTTRSazBocDVVWW5yYWRZYU5Uakx4VDNZWFpo?=
 =?utf-8?B?K0hsNkVyR0ZVWkEvWk8vTGtDZHRoa0VxeXEwMGoxT1NNZGNLeWx0VUpON3hx?=
 =?utf-8?B?YXVOVysvaUZvUmE0R0tPSDlyYmxOajZoV2xEcWZnS0djNzVCd1lQbHdxcTRq?=
 =?utf-8?B?bDFVdTYrRExuTjF0eFYxWU81WkJhdHlZYlUra3NoMEwxV01MaUZaMGRxMEMw?=
 =?utf-8?B?UEloQkg3MWdQMnhMSFpvajlWbWtNMVJhVkhVMXVhVTFXRytCeHFLemRmWGhX?=
 =?utf-8?B?MDh1RXJJd2kxMGxIMEhuYWlMaWlnVk9URTZZR05DTnhuZjRoWUNwd0FpdVlw?=
 =?utf-8?B?eHdHdzBLQkdzTFA5enRtdVpMZzZwYnZaYTBjWnRNQ0FYRnBmTXZEWWR5WkUx?=
 =?utf-8?B?WkVPNjVvelAvUnZPRkkza214VThsQVhyRTgwQ2M5VkkyY21rSUJEdDVqMGk3?=
 =?utf-8?B?NS8yazBwa2ppVXlGTGRPN2daUXRLUS96RDAyV3NaSlRjQ2JUMHR1TjZMbjN2?=
 =?utf-8?B?T3ZtalJpUjhWOUh0NGVINmtTK0lyR0xuaVovMnUzc29jMWdjSjFsOGNSNVRh?=
 =?utf-8?B?VTRXbFJEWG1KTnZYekI5aGxUaU93UTc5akc4dzF5YmN2RXd5bUZuWVg2clFD?=
 =?utf-8?B?cEEra0NJV3p2TmlHVysvT1BRdVpMRjJhT0h5QkxnR3JTMzJmZ3hrdWlMUkpu?=
 =?utf-8?B?NmZiYnJSRktoZk40TmdyYmxkVDJDakswdTR4WWVtb0gyS3lmNUxqV0tLU3Mx?=
 =?utf-8?B?VEhvNGJzWmN1SG9nMllESDV6MjNiN2xWSm9DT0tNWUM0VGEwSHBpeG1xZTJn?=
 =?utf-8?B?eXYyamhUeW5MWVJlRXJiU082QmtkTzgxcHM0MWJEYTZEeUtSdHRsaVUvZmg0?=
 =?utf-8?B?V1VZTVdZK2xnYmx1VWQwNjhuWnE2NXlKSDV1R00vSCtMRTIyUGh3d0VHQ28y?=
 =?utf-8?B?T3QrWFBDcXphWEJEc1BPWVRxdGpZY2xLVUJ6SmlwcGNLYUdLdStTRFBiNmQr?=
 =?utf-8?B?Q0JYZ1FWd3djLzVuV1I5ZTAzMGIrUGNteWVXOW4yMWFyVWtSZ0ZLVU45Wm5Q?=
 =?utf-8?B?c1psYUNTL3daM3VlemZCbjFDTSs2THZPVThwNEpubzEzNjBUcnROSGJNaGdW?=
 =?utf-8?B?R1czYmRNdkpaUUgwekVCL1VCeTQ5RGt6dXFLZlJSeWg1THJtbVV2ek1jTVgr?=
 =?utf-8?B?ZWJnVEQwRmZJSVhSVTk1Tm0rYkUzRFdYc3lmT2QrUFFGV1JTYmlMQnkzM0Y3?=
 =?utf-8?B?a25DeVo1ZitUbWlTYjUrb2ZITGhOazd3elU1Z2xqZWJsTjFQVUNVYzE5aDY0?=
 =?utf-8?Q?yBFPvfmQDeU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR11MB8118.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aTVvQU1IQnBoNzFGL2RZSjdsb1ExemZNS3o0UWJWb2w5NVNCR2VnMnRhekt2?=
 =?utf-8?B?dlBRS0xsY3MwMjdXckJVWml0TVdUNi8xcTVJZEMwTFh4RlhYWjFQYjdZV3Vy?=
 =?utf-8?B?aEc5OHNmazM3OUJXSlhZTHZtSVdIT1Z1YmdrbWZDUExmQWkvcldvcFc4aU00?=
 =?utf-8?B?VWVNVEp3cFd4SWV3bzZvWkt5TjZrTlVscTQyT0NXTnFIWTB6R3hDUWh0NTJz?=
 =?utf-8?B?RmZmNnRIYnJzTmxRd09vbi9vRTA1Sm1lbE5YS2l3Tjc0U3kvdXBERjBCc1lk?=
 =?utf-8?B?VFJhTnNxK2dLUkZEWWFscnJNU3VUbC82OFZDdWs5U1Q0ZU9DRU1PSEdFZWE5?=
 =?utf-8?B?K1RFaWRmcFV1UGNQUS9RVkVXbEFHYldPNThBNTR3K0U2RUtOWEN0SThWaHBG?=
 =?utf-8?B?NzYvdSs4MUtmMkxNT3p3MUpwczJmZ2VsSG5pbCtWMDM1dGJDbFJnenZxSTNW?=
 =?utf-8?B?Ulgyc3pvWVh4Umo0OEp0ZzhVd0t4Qi8zdS9IenhwNFp2dUxUWGFWaW55UCtL?=
 =?utf-8?B?VkN2cWtwZFdCcExDbE5oV3ZuSSt5U2N2WmJsb0I3SS9ZNlFUOGk3ZWRpWm84?=
 =?utf-8?B?MTh3QkV0ZStLcWFkWHdsTU9TNE9hb3QvdWdRZm5EbGJwVkVkM01zMkVRYnMy?=
 =?utf-8?B?SFN4YkkwMFd1ZlJwdmt1aHo3NDNkZ1EzTmV0dC9MOGZhV3oyR2pOVGd3QVY2?=
 =?utf-8?B?bG1FYlY2YnRnbXh3bDBKYldDMGNPeHhmanhQTUtYSjQ3SEtQRmpiakFlSUxl?=
 =?utf-8?B?SldqZGVEYXkxSWVBNFozZ0ROTjFOYWZ4NkR5bSsrRjY2bklOV0dhaXJ0VW94?=
 =?utf-8?B?Qkl3V0R3Z2Zqc090SytkVmdNTTJHWTFFRDZGUTBPNThLMEtzOGxDc1lGVG44?=
 =?utf-8?B?Yi83SzVtdnpWSUpUV0s3QWRIbFZkczhMYi90bDU3eG5OUkdOaExMemx1ZlEr?=
 =?utf-8?B?MGlRN1VqeHlqaDhySnUrU0t5WTg4NlJscTF4YVAwSTV0SkJIYllCNUNxSi9p?=
 =?utf-8?B?Q2dQUGRtWDFWMEhCK3UvYko5eGpPVHNrQmJXRFRHOEV5Q3M1cmR4Y3ZkN2xJ?=
 =?utf-8?B?cjNGcG5pb1JLa2RrZzBjVUEybnE1T3R0K21FL0pxVitxUEtmdkFva2JFWVpp?=
 =?utf-8?B?MFUzSExIeW9wRnpCRGdSb0xkbFJIMHhaVis3a2VVbGs3cDJiM2tob0U4YVQ4?=
 =?utf-8?B?YjZPRjhIUHlwenFNME5GV1FsRkp5UmFSZ1kxTExGY3FPQ1Q1YW5nR3pnTmZ6?=
 =?utf-8?B?QUxvVHlFeWp3ZW51RWhJekpibU85bDMySXltcGdQUUk3VWZlL3Rab3BrT3g2?=
 =?utf-8?B?NCtnbTgzczJxOVlRd3VaUi9IZ0Fra2I4dWhkdmljT1E1NSszaU53bGR3SjU5?=
 =?utf-8?B?TjRQbmJ6cjFWN1V1ZlpuTjNXenJGRGJNL2tWNmZreDYvQ25idTBiYmJhcXM2?=
 =?utf-8?B?N1YvbWVESEUrU01pclZrL1BDTmc1WVpDdG95S2lBQU9ma1EzdHlLRzd6eDFJ?=
 =?utf-8?B?ZTJSYTJMWjVnMy9hcjI3SU1ESEJzejFjTGRLZDNiS2RhSWNMbm9Td0Z1MlRo?=
 =?utf-8?B?a0psaDBoUmZ6eVVhcEZkczB0Ny9FMzB4cTdIZWdHZW1pTmE3VjRWTHhVN2hF?=
 =?utf-8?B?UlQ2N2NEOVlISWlZMHBZYkhiQzZHa0luclZDWEhib3dEeHIzSlpIVStZQTFN?=
 =?utf-8?B?emgwdVhmY2Fra01ob2U3bUNVcy9rVmRzRXlLaXU0NWg3OEpsRHVqZ0NOQy9E?=
 =?utf-8?B?bUNDS0JmV3dvaE9sZWduWmQyWHV0WElWbjFlMmpNaWthYUJtakZCTWFtdmlM?=
 =?utf-8?B?bVNhWWlLTVRkRWw1QzNFUjlsNE5ZOVhHaTZTYTlSWjh5YWMwNEZiRHlBc3g4?=
 =?utf-8?B?SjlLem1lNnJtVHhsNFpETk01VXIrM1c0T2haMHhiWHZPSFY1bzVCQXlhT0tH?=
 =?utf-8?B?VGlrMXEzeHFGNGlFbi94Q0FJUGo3UzFEL3pNVFB3MzU0cEw0MGNqQWlQVlR1?=
 =?utf-8?B?SDhJMmFLZ21jVmFJOVdHRTZsWEh6N1JDeFdGeGNpT0hBRU9Mc0pTK05ZVGFK?=
 =?utf-8?B?bHZJWjRSYmNGZi9yUkdQd1dBelpoZkVteThPL2EvSW9rQ2tPa3FHNUxOanV6?=
 =?utf-8?B?REM0aForSkprRnYrdUk5WFBSS1JoZERlTTRGdEx2TllDU1R1Rk4yNDBsd3Vz?=
 =?utf-8?B?ZFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fc1cd226-254f-47d1-b73e-08ddd46df8bb
X-MS-Exchange-CrossTenant-AuthSource: SA3PR11MB8118.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2025 22:18:15.0595
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DqY+S2matywUjMiFVR5xaZh9gYeUebJLXozmAKyZOwIrZovGEtjNIU6fjGp1eDjeI/XWpi5yWJRPorsVK4k95fQz962yx+40I75o+1OcDhs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6842
X-OriginatorOrg: intel.com

Nikolay Borisov wrote:
> Tracking the lockdown at the depth granularity rather than at the
> individual is somewhat inflexible as it provides an "all or nothing"
> approach. Instead there are use cases where it  will be useful to be
> able to lockdown individual features - TDX for example wants to disable
> access to just /dev/mem.
> 
> To accommodate this use case switch the internal implementation to using
> a bitmap so that individual lockdown features can be turned on. At the
> same time retain the existing semantic where
> INTEGRITY_MAX/CONFIDENTIALITY_MAX are treated as wildcards meaning "lock
> everything below me".
> 
> Signed-off-by: Nikolay Borisov <nik.borisov@suse.com>
> ---
>  security/lockdown/lockdown.c | 19 ++++++++++++-------
>  1 file changed, 12 insertions(+), 7 deletions(-)
> 
> diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
> index cf83afa1d879..5014d18c423f 100644
> --- a/security/lockdown/lockdown.c
> +++ b/security/lockdown/lockdown.c
> @@ -10,12 +10,13 @@
>   * 2 of the Licence, or (at your option) any later version.
>   */
>  
> +#include <linux/bitmap.h>
>  #include <linux/security.h>
>  #include <linux/export.h>
>  #include <linux/lsm_hooks.h>
>  #include <uapi/linux/lsm.h>
>  
> -static enum lockdown_reason kernel_locked_down;
> +static DECLARE_BITMAP(kernel_locked_down, LOCKDOWN_CONFIDENTIALITY_MAX);
>  
>  static const enum lockdown_reason lockdown_levels[] = {LOCKDOWN_NONE,
>  						 LOCKDOWN_INTEGRITY_MAX,
> @@ -26,10 +27,15 @@ static const enum lockdown_reason lockdown_levels[] = {LOCKDOWN_NONE,
>   */
>  static int lock_kernel_down(const char *where, enum lockdown_reason level)
>  {
> -	if (kernel_locked_down >= level)
> -		return -EPERM;

So now attempts to reduce security return "success" where previously
they get permission denied?

I think that is an unforunate side effect of trying to have this one
function handle both levels and individual features.

> -	kernel_locked_down = level;
> +	if (level > LOCKDOWN_CONFIDENTIALITY_MAX)
> +		return -EINVAL;
> +
> +	if (level == LOCKDOWN_INTEGRITY_MAX || level == LOCKDOWN_CONFIDENTIALITY_MAX)
> +		bitmap_set(kernel_locked_down, 1, level);
> +	else
> +		bitmap_set(kernel_locked_down, level, 1);
> +

The individual case probably deserves its own interface given all
current kernels expect levels and the future callers probably want to
skip the pr_notice() below given only piecemeal features are being
disabled.

You might even special case just LOCKDOWN_DEV_MEM for now as the only
once that can be indepdently set by an internal caller.
