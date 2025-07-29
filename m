Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A25FD286413;
	Tue, 29 Jul 2025 23:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753831713; cv=fail; b=fQDoPaFgLhUhNlTn+pnhNx5wUeKj+UubjXFvsxGtpHvlHF5s4KLrfh4Cj3WwhGUOyKKzTBUBOHs3rwYwcxiULn59PZ9x2R7Jys3H61nrqgVRcGWGHtAJmZjMUH2wOVNSxWkful9V70JfuRMuZnB+wW/N9ZZw8Btg/LtoIh/tkUQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753831713; c=relaxed/simple;
	bh=bTqXfeHW59NqHcqiTw2Q5RRs9cAUstW9wCA3er8cWGY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=h3ciGMiZjchL+kSxyf9tUtoKToBJZI0Ok9AwgddGeOxjrXGO/4Jl18bIK9x6NV+fA4lB/ymXCwsuNavlo2EJ5tZ39HXk9HdaOFZ5VVodXDoNofrnfN5M4HReo/KJLJwF/lfy4wtqli9pasiWgofhVWZwZJ6qcNSuGaS3EOL8m1k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VH1jFsgL; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VH1jFsgL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753831712; x=1785367712;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=bTqXfeHW59NqHcqiTw2Q5RRs9cAUstW9wCA3er8cWGY=;
  b=VH1jFsgLMk46u8BDX8vmiNKTPvrKexS27AV08D7jc0Xfm9a/0Z96Kkrh
   nAB7r2MMkX9ZgkNtSPi6NjFmH3YyIDG0pCSICWX8Ce/rZblX29zHUG7aM
   Oc8AJo9gx9/UlR0W+lQ9MlOQ2C2A1xEFqECYwGBG2AbzodHJZdCY/5mPX
   N0nangLELAMtBaNbYew8aRxEQiGjCHzwMVNjWkt1HQML6RBmrSrelgut4
   RDb7wjPyxZpGU0ZUDTyxDpV3JuED+65oQbGIw61rGCkvGXkuNi06ADtYS
   wifvRevLvcSOLA5Ho/X5MX8VkUYvD25uVMgNPqGDqNam3kDpao8lEVtLZ
   w==;
X-CSE-ConnectionGUID: JCR1qtDOR4e8aHB90gaaIg==
X-CSE-MsgGUID: jW9uG/G4R9CSXsUjlJ6chg==
X-IronPort-AV: E=McAfee;i="6800,10657,11506"; a="56271508"
X-IronPort-AV: E=Sophos;i="6.16,350,1744095600"; 
   d="scan'208";a="56271508"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2025 16:28:32 -0700
X-CSE-ConnectionGUID: SI49KFteRQCd3nmD+NGqLQ==
X-CSE-MsgGUID: JFIC1S+nSU+Bsu5d4Riedg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,350,1744095600"; 
   d="scan'208";a="168234906"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2025 16:28:31 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 29 Jul 2025 16:28:30 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Tue, 29 Jul 2025 16:28:30 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (40.107.212.55)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 29 Jul 2025 16:28:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YMr52p/LWP3mROIS5+89HLDHwg5JA9zt/93bI8A6NlX0AWrEBZboZD2q2jKaxsM6mSaAEimlgHw1YYjRXMoZMyKFcEnV5lEmGhLNfe5npkYarTYM0nLvrXDWdZgSQcasu9n4t6H/e/9DniELQ5D4LUhyj8cYob1JPWtkYPDvdqH3uQVrgbzUGgkl/E0+u7Ffrk3r/MjFdoevbYqLDz9fdknjX9EFNsdP68UKVZEXbzAb83yXip9cNXnvwtjdTAa8/5EE0Ob0L0qhUDY1RFmSaxgZUZw4/x3W5rxipNuSUZJ5AgLZmlbwUfa87A0xo4VMx34KPD6k50811magWMrMKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fyPVGuRQ/oxbKwk1LruuyYjmEVMq4QhIhx5qDCAwI+U=;
 b=CRSbI+kpcSCeqpNLYQ/ZFvKF2n/+r6WKxP9jY8NSfA7NEo1KVtN2yYU54zaA8NLohAh7BXCC1lVeIJ4QyIo/dwYrWzBmUpELPFwSNICxCDRgSN6BagrdzC1qwbMaIMFAOQ9uiGM8+fB9G1hBT11RY8W37mbiH/zzl1w1oG4ZgIFEWTWl4I499YoOy59N/AwgPJ+9Th2U7OqGk+h8D6uYDHp/buJXAKJ7r5YvW/+yC2yKp+6ZfeFLrWE2MflO+x6dDt8Wtqcn8UkEtR1pZato8pCTuEZ2G/vF9c5l4LbrkKIgD7JLjkTVV4vWRpkbcBbiXsSis88Gx+MOwYhfWaiu/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5674.namprd11.prod.outlook.com (2603:10b6:510:ec::10)
 by SN7PR11MB7065.namprd11.prod.outlook.com (2603:10b6:806:298::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Tue, 29 Jul
 2025 23:28:28 +0000
Received: from PH0PR11MB5674.namprd11.prod.outlook.com
 ([fe80::77d3:dfb2:3bd:e02a]) by PH0PR11MB5674.namprd11.prod.outlook.com
 ([fe80::77d3:dfb2:3bd:e02a%3]) with mapi id 15.20.8989.010; Tue, 29 Jul 2025
 23:28:28 +0000
Date: Wed, 30 Jul 2025 07:28:19 +0800
From: Philip Li <philip.li@intel.com>
To: Nikolay Borisov <nik.borisov@suse.com>
CC: kernel test robot <lkp@intel.com>,
	<linux-security-module@vger.kernel.org>, <llvm@lists.linux.dev>,
	<oe-kbuild-all@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<paul@paul-moore.com>, <serge@hallyn.com>, <jmorris@namei.org>,
	<dan.j.williams@intel.com>
Subject: Re: [PATCH v2 2/3] lockdown/kunit: Introduce kunit tests
Message-ID: <aIlZE8i/XzSFWS2U@rli9-mobl>
References: <20250728111517.134116-3-nik.borisov@suse.com>
 <202507290540.9IANrMED-lkp@intel.com>
 <c2754ac3-28d0-4c6c-bd2d-0dcc9ca66b77@suse.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c2754ac3-28d0-4c6c-bd2d-0dcc9ca66b77@suse.com>
X-ClientProxiedBy: SG2PR04CA0173.apcprd04.prod.outlook.com (2603:1096:4::35)
 To PH0PR11MB5674.namprd11.prod.outlook.com (2603:10b6:510:ec::10)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5674:EE_|SN7PR11MB7065:EE_
X-MS-Office365-Filtering-Correlation-Id: 731732f8-6a38-4a70-88f4-08ddcef79f36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MXN0ck8wWlNqcHJudGhQV29Sbjlwdkd6NDRWWjVBUDFaL0s0RTBUSXdRNlhq?=
 =?utf-8?B?YlNtMVlxdE1PdS9nYXRXSHJuUndPdm1yUEc2bnlFeEx2M0VJSVQyL1JtUW1E?=
 =?utf-8?B?elVJQXEvemN0SUpXaFZSTisxUkMyUDJaSVV6TG9NWEhrZFlKbEpGbTlvbFlW?=
 =?utf-8?B?UFNUTCtwdWZNRE1Ycyt3Q2tHbHAzZmt5RTZRVXk3dGxKWjY2ZW0zVEw3SUU1?=
 =?utf-8?B?QjZSVXJ5NjFLazZQQ1pZc1c5V0VKNGZaRXRPdmdPVGdYVDNpQXU0Yk1pWjhH?=
 =?utf-8?B?SDVLNUxsZzJDQWV6eGNVMWJkYjZDRkVkY3N3T2x6VlhoYTEwamd2ejI2Wklh?=
 =?utf-8?B?c2xtYStmc2FvemNaOWNVeDk3dEtZMUtUc1BmTm1jcHdiSHB3eDErOWV0STVh?=
 =?utf-8?B?K3RLaitIcW9QR3hOY3VBc3ZZVVBKTnhJYUlTM0txdDZlRmlRcWJZaWkvTXhP?=
 =?utf-8?B?T2hXSDFCRXJEZkk3bFRYMVo3R3pxUGJDSloxMTdydHF5US9JU0FJS0hpcnNk?=
 =?utf-8?B?blQ4Q3ladFQ4NXNkTUc0V1IvWnVyTytzaitlZGtIS2dkRGxWeHBRcGNxdkFi?=
 =?utf-8?B?VEVvR1p0WXJXTm9icGgwcTd0WWlwZ3pDVUVLTWxyN0ZTejNpdWlpUkVFeEtZ?=
 =?utf-8?B?NTJNaTBsYmVHQkhTWDJlckhCZEZwbWRSVnRVVUZuZnU2OTJ4OVNVSjdGYXBl?=
 =?utf-8?B?TDNwQlZFMmxYdy9kWWJHMi8xc1dHZFNDeHU2QjFScGwrMkVXMXQxTDNCYk4y?=
 =?utf-8?B?Y3k5eWF2MjhOM1ZWVUxtSzBDNWdMYW4vMEgvaXEzSTBlcEF0RDJrcDFLcm1m?=
 =?utf-8?B?WlpjSXFTcVpCenp0ZUlINUwyY1BJd1hHNUZveGZUT3NSL2NFZE5pT1grSGdI?=
 =?utf-8?B?Mmxpb3VWemJFdHJIQm53YVFROXpFMmY3anJNUmhYQ2pYRkZhK3F6OGRpS0Mw?=
 =?utf-8?B?ZmFDTVBSSEJxcVpjUWM4Z2lyb3JiQkdSWUZoYmcrYTFpR3FxSGFQdHNPSEdP?=
 =?utf-8?B?LzF6dDF6bjhiUkY1UlRWakg4M0JqaFlFNVBYT01TaVA3dll0QVRnVjF5OHVa?=
 =?utf-8?B?amdOZFVXT0htSnNwdE5IYlV1cTdIWmZjRnRibHM3bzR6UjZ2MkJZQkFDMEpE?=
 =?utf-8?B?clhUd2tjL1dNeHh0d0llL21Fa2xIOFlKK2MrVmdRTTljM1R1MEk0YnV3UkRr?=
 =?utf-8?B?OUxldmgrdWw2Z0hQOUlRemxxNTk2dnV6YURpYlZaclYwcWp1NlV0VUNzRXFU?=
 =?utf-8?B?TnhFa0laRVJWWXQ2ZytNMXIwVXg5UWhFZjR4TGppWHRobDVUcHVselN0aUxC?=
 =?utf-8?B?M1NjdUY5YytHVHpCUlMvZEF6M2t2Qm9MRE5nK2ZNdDJJdE5sdFpoakNiczBO?=
 =?utf-8?B?U2w0MzJNWWppOG9DSkdxZmY3SDVsb2NJT1R3N1VRU0pWTEpDMzd0OHNKWmds?=
 =?utf-8?B?bWhpRFptcE1hWnNNczhTWG13d1RwUHlsRWJ3Um05TkpTYjdmZVE2WVNDVUdK?=
 =?utf-8?B?M1dwc3JScVJpeEpIL1pQRndIbzltclRQZ1dMeGNuMXR3NHBmNDgyc3doWkVP?=
 =?utf-8?B?ZGQxU2JlL1V5N1VFcWF2eFR4WS9FbWFGM1NuejhyZE1JSUxQYW9rWGFiZzF4?=
 =?utf-8?B?MGlpd2puUjV4djNTc0YxR1NqNE5FK2tJY0UxY3dVamV0RjB1aW5YSmpGajZN?=
 =?utf-8?B?dnZBN05MQWZQZkdkNHRtZ3Z3MXE0ZkIzcm0xRjVGY2dOTWxKVGl3RGVqTndk?=
 =?utf-8?B?T0RJSDBodzA3MW1Da0NrNmk4aFR1cVJva1NBOTZYTUxpd2tkcVkwcXBrZXUw?=
 =?utf-8?B?OHRuOXpWWXZTVkhlK2Z6Wmc3V3d2T2hzVVVZNU92ZkdqNVZFNFcvN3Q0Smtq?=
 =?utf-8?Q?IP8s66FenyEOA?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5674.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Nm83K2JUdnQvYW8vK0M2QURYRml1UHpnUDY2Qm5tWWRkaEluWXpRSmJNcDZJ?=
 =?utf-8?B?SW5KY1VodTRmT2MvbGVCZUcwNXpZTEpGSWNSb1ppK2NpVEpLZ28vbDdkU1RG?=
 =?utf-8?B?aTVnUG1mSG1wc0luWjgvQTloN3Z5Ni9RQ0lkZ1gvR3JoQjhQYkQxQ0lQZUVK?=
 =?utf-8?B?TXQ1Tzl1YnlVRWx0NktWUlFtdG9TTUd1L1hZZ3NpaDdEdUZWem1MRUw2alN2?=
 =?utf-8?B?RlRRN0VNRGhwZ2cza3FCemU1ZG5FdWNXc2c2LzlBOTkxMy93MHVlRjlWc1d4?=
 =?utf-8?B?OXI1Uk1GSGdUM0paT2h0cXVOME5QVVg4ZHR2Y1ZQRjBsc0tkNEs3NVg3UGhR?=
 =?utf-8?B?UmROSXRYdGJwdlRxajZjZUlBcTYvbFh6YXVjLyt0K2tLSURKR2cvNC9DQWlm?=
 =?utf-8?B?WDJMS09ucUR1NHZGUlZCcmdPV1hUekhHOUR5VTFucEF6cTJKMm1pR0NzOUk5?=
 =?utf-8?B?cmozWlRFSTUxMDAxSE1jbXJLSEZEWHFBNmJuL0FjSGEyUitPQlJjcWlhcG5a?=
 =?utf-8?B?UDBqalQwbnk2anlvMlFkb3ByQ0ZvRStseW9yWk9lUEJYVW81ZGtGRVpmZWdI?=
 =?utf-8?B?OXIyRG56ZjJwQ1hWMk9kanF5bUIrbHRwdTUwQ0t4Yzh0dVFYeUJvT0toSUZM?=
 =?utf-8?B?YzdMNzgyem42SnRWVmdPeHlheXByL2VNU1lQSDl4bVBZWlBLVG9QYjQybnc4?=
 =?utf-8?B?OWJINzJnSDNIb1BTVkI3Y2dJTmtQcHVyZVE2bytrUExQZHNvQWdRdXMzZHpY?=
 =?utf-8?B?dGk3Q2w0ODlnelA2SkF5ZDBIeGxBV3Z6Q0dvb29Ld0ZrdUFRNnlWNHV4Q2RC?=
 =?utf-8?B?VzFWWm1odzQ1c2RneDNRTkJrOTBRZlRkYnVOWVhyeFo0ZGJOZHFrWHNISEVS?=
 =?utf-8?B?TitYdXhFT01kN3ZkVVFJRTFTaStmeDdXVHFJQTRzWnlzU2VqZmE5enozSTBw?=
 =?utf-8?B?SnF0T2FSd0daMDgzN3Q2SlBuZjZIeVdmTlh1ZXBuZE82WFVZWnNKR1lxRTgw?=
 =?utf-8?B?NW91UnFIYlNtL05rcGJSZUdlbVhTVnZ0NmI4dksvcTBoNm5zaVVNa202WWY2?=
 =?utf-8?B?NXM0cE5NRllUdjFmTnBKL1BzNk9lZEk0ZFB3MWtLL3RsenpJOXo0aDVxdGpX?=
 =?utf-8?B?VTBnRzU1bHdZL1RTMmVKZkRIWmV1Vkp2ZnhDbnhpWDRoZTdRUHlIOTNiZG9n?=
 =?utf-8?B?cktyZXpQd096eU4vSUlCU1R5eFVNK1NKc2hEUEpRY001WFFVeHRGdStIcmRS?=
 =?utf-8?B?eDYyRm1jWXozZHYrOUtXbGhDZmxDeTZWeERmWS96ZjRPbVRKdUpmc3dEOGVQ?=
 =?utf-8?B?MTMvMDZyZnlmR3M4Z2FNOU9YY1d0OC8yMkFJS0c0aGdNSEJRNnlxNTc1T3U5?=
 =?utf-8?B?WXYxTXJmSWw0WFYrR282U2s3MkFQQ25iWVJVL3ZWZHhUNjF6aSt6blhyOURC?=
 =?utf-8?B?cGFhcmc1S0VOS2hLOWpLZzMrWXdkWW1tS3ltTU1jWmtMQ0RNeVBJY2YrdlNk?=
 =?utf-8?B?Z3M4VlRJWWk5NEVNWGVjbjlpT0J5V3d2YXR0b0hMN1k5alFLYkZ2VGVjYnFy?=
 =?utf-8?B?RnNpOFJLKzlBUitKN1ZJMSs1cGtJeEozZ3ZsWmhKVndibkdKajRtSVY1eW5L?=
 =?utf-8?B?bmo5alFvakx5NUZDYWJhTEVQYU1ONit3bi9iQWFBOTZNQU14Znd4eTVGZjN1?=
 =?utf-8?B?OEFYQTZoWjl2U1NHYlNQMU9oRGtIbHN6UTNRRGFOVXlVZEUyV2VwVEJGSUp1?=
 =?utf-8?B?anY4Mi9qc2hwQUwrWDNqcC84UDZUQU92N2F1NEJkSHVUUVNHSWk4ZHJWaDNB?=
 =?utf-8?B?UEVLbGlVbmRBZk1xY3JUMjd2UTRxUUtiM3dlOVZ3QVFHckEwN01OTUxGOFE2?=
 =?utf-8?B?Tm1zNCtJbE94ejZtRjNDUjhNOWp4WEwwNkp3T3Z4b1F2dXVlS1NUdlNkZlcr?=
 =?utf-8?B?YWpOcEp5MXArR1JYaEZqTVpKeHVWTUZCQmIxcldkZUh2SlVmR1hTMWZDRDVD?=
 =?utf-8?B?VFk0VHdFSUVzbUtlVGJJVlpZWVJXL3RRY0FLRUhUckxvVDNqdXJMSDlMWE9o?=
 =?utf-8?B?Ukp1bkpuTG85L2lCRTdWZlVScmV1b3BvYk1qSUxtSnN2bGwwS20vUTdmWko5?=
 =?utf-8?Q?6JBnQrDkUlEJ+xBYQnttnV8ga?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 731732f8-6a38-4a70-88f4-08ddcef79f36
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5674.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2025 23:28:28.3343
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NqN24Zji/ZxVAEU9EtztRaooXHr3e/0Vlx8B1ocxDrxaHYEYI72pVNL5YbHyD95PzzYHEAoIUxAxhcz9sEIHsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7065
X-OriginatorOrg: intel.com

On Tue, Jul 29, 2025 at 10:46:48AM +0300, Nikolay Borisov wrote:
> 
> 
> On 29.07.25 г. 1:04 ч., kernel test robot wrote:
> > Hi Nikolay,
> > 
> > kernel test robot noticed the following build warnings:
> > 
> > [auto build test WARNING on linus/master]
> > [also build test WARNING on v6.16 next-20250728]
> > [If your patch is applied to the wrong git tree, kindly drop us a note.
> > And when submitting patch, we suggest to use '--base' as documented in
> > https://git-scm.com/docs/git-format-patch#_base_tree_information]
> > 
> > url:    https://github.com/intel-lab-lkp/linux/commits/Nikolay-Borisov/lockdown-Switch-implementation-to-using-bitmap/20250728-191807
> > base:   linus/master
> > patch link:    https://lore.kernel.org/r/20250728111517.134116-3-nik.borisov%40suse.com
> > patch subject: [PATCH v2 2/3] lockdown/kunit: Introduce kunit tests
> > config: arm-randconfig-004-20250729 (https://download.01.org/0day-ci/archive/20250729/202507290540.9IANrMED-lkp@intel.com/config)
> > compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 1b4db78d2eaa070b3f364a2d2b2b826a5439b892)
> > reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250729/202507290540.9IANrMED-lkp@intel.com/reproduce)
> > 
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202507290540.9IANrMED-lkp@intel.com/
> > 
> > All warnings (new ones prefixed by >>):
> > 
> > > > security/lockdown/lockdown.c:31:5: warning: no previous prototype for function 'lock_kernel_down' [-Wmissing-prototypes]
> >        31 | int lock_kernel_down(const char *where, enum lockdown_reason level)
> >           |     ^
> >     security/lockdown/lockdown.c:31:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
> >        31 | int lock_kernel_down(const char *where, enum lockdown_reason level)
> >           | ^
> >           | static
> >     1 warning generated.
> 
> 
> That's a false positive, since the function is exported only for KUNIT case,
> what's the correct way to make testbot ignore it ?

thanks for the info, i will configure the bot to ignore this firstly, and
later to check whether there's any pattern for more general ignore. Sorry
for the noise.

> > 
> > 
> > vim +/lock_kernel_down +31 security/lockdown/lockdown.c
> > 
> >      20	
> >      21	static const enum lockdown_reason lockdown_levels[] = {LOCKDOWN_NONE,
> >      22							 LOCKDOWN_INTEGRITY_MAX,
> >      23							 LOCKDOWN_CONFIDENTIALITY_MAX};
> >      24	
> >      25	/*
> >      26	 * Put the kernel into lock-down mode.
> >      27	 */
> >      28	#if !IS_ENABLED(CONFIG_KUNIT)
> >      29	static
> >      30	#endif
> >    > 31	int lock_kernel_down(const char *where, enum lockdown_reason level)
> >      32	{
> >      33	
> >      34		if (level > LOCKDOWN_CONFIDENTIALITY_MAX)
> >      35			return -EINVAL;
> >      36	
> >      37		if (level == LOCKDOWN_INTEGRITY_MAX || level == LOCKDOWN_CONFIDENTIALITY_MAX)
> >      38			bitmap_set(kernel_locked_down, 1, level);
> >      39		else
> >      40			bitmap_set(kernel_locked_down, level, 1);
> >      41	
> >      42		pr_notice("Kernel is locked down from %s; see man kernel_lockdown.7\n",
> >      43			  where);
> >      44		return 0;
> >      45	}
> >      46	
> > 
> 
