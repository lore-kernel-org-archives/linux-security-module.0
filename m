Return-Path: <SRS0=8CgQ=QF=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75143C282D0
	for <linux-security-module@archiver.kernel.org>; Tue, 29 Jan 2019 14:17:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E9062147A
	for <linux-security-module@archiver.kernel.org>; Tue, 29 Jan 2019 14:17:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727145AbfA2ORB convert rfc822-to-8bit (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 29 Jan 2019 09:17:01 -0500
Received: from mga07.intel.com ([134.134.136.100]:3361 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725772AbfA2ORB (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 29 Jan 2019 09:17:01 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Jan 2019 06:17:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,537,1539673200"; 
   d="scan'208";a="314521576"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
  by fmsmga006.fm.intel.com with ESMTP; 29 Jan 2019 06:17:00 -0800
Received: from fmsmsx115.amr.corp.intel.com (10.18.116.19) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Tue, 29 Jan 2019 06:17:00 -0800
Received: from hasmsx107.ger.corp.intel.com (10.184.198.27) by
 fmsmsx115.amr.corp.intel.com (10.18.116.19) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Tue, 29 Jan 2019 06:16:59 -0800
Received: from hasmsx108.ger.corp.intel.com ([169.254.9.155]) by
 hasmsx107.ger.corp.intel.com ([169.254.2.13]) with mapi id 14.03.0415.000;
 Tue, 29 Jan 2019 16:16:57 +0200
From:   "Winkler, Tomas" <tomas.winkler@intel.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
CC:     Stefan Berger <stefanb@linux.ibm.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        Peter Huewe <PeterHuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "Struk, Tadeusz" <tadeusz.struk@intel.com>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        Nayna Jain <nayna@linux.ibm.com>
Subject: RE: [PATCH v10 00/17] Remove nested TPM operations
Thread-Topic: [PATCH v10 00/17] Remove nested TPM operations
Thread-Index: AQHUreHHpwNI+OEb4EipFSW6DRZudqW9E3qAgAAJKACAACHQMIAI4diAgAA96WA=
Date:   Tue, 29 Jan 2019 14:16:56 +0000
Message-ID: <5B8DA87D05A7694D9FA63FD143655C1B9DA88D6A@hasmsx108.ger.corp.intel.com>
References: <20190116212342.24524-1-jarkko.sakkinen@linux.intel.com>
 <20190123182057.GA24212@linux.intel.com>
 <37e53df5-4a25-fce2-d3bf-016669d0a383@linux.ibm.com>
 <5B8DA87D05A7694D9FA63FD143655C1B9DA818C6@hasmsx108.ger.corp.intel.com>
 <20190129123309.GB12883@linux.intel.com>
In-Reply-To: <20190129123309.GB12883@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNmIyYTIxNGItOTc1My00NzQ0LTg1ZjYtMzQzNzJhMDFjNzg0IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoia21CNVVTNlBiN3BpbFRwNFNtWVlsTXZraE8xeVwvMVY5bXpmQlNHRGxoXC9zdStPRVJJdHJpVHp2dXArbTUwVzVsIn0=
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.12.126.80]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>


> 
> On Wed, Jan 23, 2019 at 06:59:48PM +0000, Winkler, Tomas wrote:
> > >
> > > On 1/23/19 1:20 PM, Jarkko Sakkinen wrote:
> > > > On Wed, Jan 16, 2019 at 11:23:25PM +0200, Jarkko Sakkinen wrote:
> > > >> Make the changes necessary to detach TPM space code and TPM
> > > >> activation code out of the tpm_transmit() flow because of both of
> > > >> these can cause nested tpm_transmit() calls. The nesteds calls
> > > >> make the whole flow hard to maintain, and thus, it is better to
> > > >> just fix things now before this turns into a bigger mess.
> > > > Any reasons not to merge this soon?
> > >
> > > I suppose v10 hasn't changed anything signinficat. So, not from my
> perspective.
> > > Were you waiting for more Reviewed-by's?
> > >
> > I'm okay, in theory I've cleaned all my concern regarding idle and
> > locality . I'm just want do few more tests on Sunday.
> 
> I'm in no rush merging this piece of code, as long as it gets merged at some
> point. Thomas, can you take a look at the PTT issue we are having.
> 
> See my discussion with Linus with subject "Getting weird TPM error after
> rebasing my tree to security/next-general". You have better knowledge of the
> internals so I would really like to hear your feedback on that.
> We need to get a fix for that for v5.0.


Yes, looking into in new ICL, had some issues to bring the platform on.  It's really failing (selftest) , we are looking into it.
Will also testing the nesting removal patches. 

Thanks

