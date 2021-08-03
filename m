Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 594C0C432BE
	for <linux-security-module@archiver.kernel.org>; Tue,  3 Aug 2021 20:08:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41726601FD
	for <linux-security-module@archiver.kernel.org>; Tue,  3 Aug 2021 20:08:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240388AbhHCUIO (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 3 Aug 2021 16:08:14 -0400
Received: from mx0b-00105401.pphosted.com ([67.231.152.184]:53466 "EHLO
        mx0b-00105401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240085AbhHCUIN (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 3 Aug 2021 16:08:13 -0400
Received: from pps.filterd (m0074334.ppops.net [127.0.0.1])
        by mx0b-00105401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 173K5LAk001508;
        Tue, 3 Aug 2021 20:07:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=collins.com; h=from : to : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=POD051818;
 bh=YyY1fBCN09Io4g5zYgMubqifIIh6p4ndYzStqe3SJKY=;
 b=QeZQqFdomz00feHmE+/jipgR+r1Gu1h3GMAbfE4dwMR3WCL8/N0Kvxm671omiTC3Na9l
 OZw8dLBAC6MkUyBY8D7RK6N/y95g4HreGbL4Q7VkASDsZD4Tzrww3Kg50bwiCDKULfQK
 8kgZckJKLgNO3IIHUAsMCPerkz6qy4HtXB4J1cS1SO7i0Yi5PRsxYt0OaUtZ0s6Sl87D
 WCNEJ8zfzC+0W222OQEH0wA7xtns9IgWHT2tWDAfPpqYqfOkWPHEOhTCcE40/NYbUhaD
 Ov4KS36V1NmYx/JF9MrxdEiauVkbzrSpVkUiIV8rXzw43nqpmEV8c8D2pvpWwj9w456E IA== 
Received: from xnwpv37.utc.com ([167.17.239.17])
        by mx0b-00105401.pphosted.com with ESMTP id 3a5gh4vbjf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Aug 2021 20:07:59 +0000
Received: from qusnwadv.utcapp.com (QUSNWADV.utcapp.com [10.161.48.86])
        by xnwpv37.utc.com (8.16.0.27/8.16.0.27) with ESMTPS id 173K7wD3041825
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 3 Aug 2021 20:07:58 GMT
Received: from UUSALE0Q.utcmail.com (UUSALE0Q.utcmail.com [10.220.35.35])
        by qusnwadv.utcapp.com (8.16.1.2/8.16.1.2) with ESMTPS id 173K7wBd023982
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 3 Aug 2021 20:07:58 GMT
Received: from UUSALE0K.utcmail.com (10.220.35.30) by UUSALE0Q.utcmail.com
 (10.220.35.35) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 3 Aug
 2021 16:07:57 -0400
Received: from uusale2b.utcmail.com (10.220.63.21) by UUSALE0K.utcmail.com
 (10.220.35.30) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 3 Aug
 2021 16:07:57 -0400
Received: from uusale29.utcmail.com (10.220.63.19) by uusale2b.utcmail.com
 (10.220.63.21) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 3 Aug
 2021 16:07:57 -0400
Received: from USG02-BN3-obe.outbound.protection.office365.us (23.103.199.151)
 by uusale29.utcmail.com (10.220.63.19) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Tue, 3 Aug 2021 16:07:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector5401; d=microsoft.com; cv=none;
 b=Mglj0CqhVjcQ7Tu0Vx0Z1rh+JGxOmh1cY1MD6lQ5i/DKjR3ORp7mdqDESrd+AqBOkcpBqcImy4nMWi4aBL/qOy5dqKWEsIocatcJg2yJFg9BFbslTR81QZTB84CBw+qoqLK55FkA85v7J3psgBjCMBSoN+6AwTUSKGkJpoLGp2fMnd2qY8r4CnM21Th91glPrTiIkVE58SbQzah1Y6tjGTMAG/byfmDV5u7Xi37nHuR/EWo4txJsiWYLLbxa6vwkRrQGTOKP06L4Pbfz8YFwr5mdT1a29zU0BWHre0OSEunsRqnTTQcXacXuUGEDhfrnwMudzbSfQQA+QIKKjJtUpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector5401;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YyY1fBCN09Io4g5zYgMubqifIIh6p4ndYzStqe3SJKY=;
 b=FHEnYBgX0+ECrCs/uWBbjYZToAgBKX2JpLyrjlhaNw4NE8Hc/N8br16N/3EOLKi56YLh/cXgDiAfCawDdlXKbL6JRQnVLmHL6RUFOHK4eUhX1H5Ajk4PyIm44oYwLeQH2rwmxm7oNMrjyhuEqj2zQMRlBBD6qAVp+0f2By1oF55i1X1aOOCsbTkzm87KulREI1ZsAT/212F5mzMHO0jFguUeHXHIfNNIjhecd/ByW73Mfm/aHUegmSwW9wT19/ZRTt+1+wqWXQrXHKqHL880jmIhmAsX8gDLalOeS/xMYM3uurflRdDbVSeAcAjocXZXQIX2yBBWkhKKqqn5WN3NXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=collins.com; dmarc=pass action=none header.from=collins.com;
 dkim=pass header.d=collins.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rtxusers.onmicrosoft.us; s=selector1-rtxusers-onmicrosoft-us;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YyY1fBCN09Io4g5zYgMubqifIIh6p4ndYzStqe3SJKY=;
 b=nFIHcUwQy7PWfp+DJOf8i3nCjscNJlovFMPQ0c7HSi0iWOTROWzAJtEBBPMe3L7kHRqnnhqhuxvGj7HNgoSmIrktIxHPmhbhuPhzK3IhccTdDYv2l+3XSTsgRVMOEkJiY02ew4WmgDz0q1YCUKn7H+EcTsRZ/PZdwQseqn4SPyU=
Received: from CY1P110MB0102.NAMP110.PROD.OUTLOOK.COM (23.103.22.213) by
 CY1P110MB0181.NAMP110.PROD.OUTLOOK.COM (23.103.24.212) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4352.31; Tue, 3 Aug 2021 20:07:56 +0000
Received: from CY1P110MB0102.NAMP110.PROD.OUTLOOK.COM ([23.103.22.213]) by
 CY1P110MB0102.NAMP110.PROD.OUTLOOK.COM ([23.103.22.213]) with mapi id
 15.20.4352.035; Tue, 3 Aug 2021 20:07:56 +0000
From:   "Weber, Matthew L Collins" <Matthew.Weber@collins.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        LSM List <linux-security-module@vger.kernel.org>
Subject: Linux Kernel vulnerability scripting
Thread-Topic: Linux Kernel vulnerability scripting
Thread-Index: AQHXiJ5A8WtM9EY2fEqX65Of1vnzQQ==
Date:   Tue, 3 Aug 2021 20:07:56 +0000
Message-ID: <CY1P110MB0102E9CF9461FDAA8C3B8C22F2F09@CY1P110MB0102.NAMP110.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=collins.com;
x-originating-ip: [50.80.23.253]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: eb94b6d1-751e-4857-6bbf-08d956ba626b
x-ms-traffictypediagnostic: CY1P110MB0181:
x-microsoft-antispam-prvs: <CY1P110MB0181E6FE2123BCFA3AA23D62F2F09@CY1P110MB0181.NAMP110.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ezk7OdEzhjClqWVjHn4FI6vAdS/YoziD33waVkWFQpSuHAzBKH/pVOaypSmjQwzGqXqu10oQa6XPi3wBIRVT6/pTnXsRfpa+oqKfzU/XQL83CEf9adBprfJglrL20smxO91ywYry8DW1/cPKxxkxmEG7fpe1uc9xriN9LFTk/SUEuUUM4SY83qzOXHRU7IiaXEAtNtRxgrIYZy0f6Z73H5n3ncxo4S7tVVbJeIfXq/qFAWOOYJvEBtSaD+HMJp92QrcqT288QCcP72xb838vCPnsnNiaV/L/Bxsv6IVNtH0p7Aso12sENYKb1KQ0qDMH+pJ6VjhJ+2elkqXD36wwVkqoBoykhrpWXIg+7PZM/d9bGYRUxjnN0CTI/ybpTh6s3ZB/Z3z7eBl/7jVkYSVocY1Rs2/gp/JiPyXRzqim6uf8bwOOyEbcEAUGFws5KIVlGjErq6JsuCt62VxvILsWNY5ghOOoMalVh1m2zyg0wHP46slSLzT9m0hBvYqCKgebOCuZqYnobeAVW2y95TZk59rHbnEH2NZ5C/40E9+zlf7rX7KmcxDZDTr5cHkZFfTwKVz0aNpRvE26OQH0+QQ4BOA9g2h3fkI+OIffJtFSsQA254mA5vCyND/V4+jcBg8x
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY1P110MB0102.NAMP110.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(366004)(7696005)(956004)(76116006)(52536014)(66446008)(3480700007)(66946007)(71200400001)(316002)(86362001)(64756008)(110136005)(2906002)(66556008)(83380400001)(6506007)(26005)(5660300002)(33656002)(186003)(38070700005)(8936002)(122000001)(508600001)(9686003)(66476007)(8676002)(55016002)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: MMHT9hb9UDzvbQYtEt+0yNP58IrWIFXhgxLKwSzOLGSPDwXb2c94J1Bs5eHvwIyRTyG8/I/7rx8Qu3+HeDX+cC7ex0/ThhZqS86uQEMh6yWlDE90Nrmu78qYew10zA0FQhTfF0NHRgKFyWv9CR+484VXUY7P8o55O1meFmd0U+LeO5UVmTaKhLjoKJ3VMH/y5yPjsiLQfVYBss1adN5yNoJuW1wOADa8XbbaUld866ReoilToLTSSiKP18eBPCkJBVRY8IyBOgAw+dIrt3g4jjyZ5Yh3UK/ID7t6/dILTrJJzUgQLYH0ogo6A2fGC5MxW6JX66ypEpAg+2KBQZIctY5cBeifspoLowDTpS3CH3oY35MuYBtbjgtUuiJ0auBDZFI0X/qoJq62Nczt53CtJ6tquiIfVJ+BERS+jlFTmJHEov6bfnnJBq5+PDTUGCoVtZVioesysoUkUriwlAnyYvDIbXp/J530DMx8pivu+7mmsFs1Y0r5QDRmcxzP2jrUNJDN1PIpC0NtRObNas+n8POIWdYqZfmk4psxC7YOF7zJaisPTnWMCQ6ljsF6cdW79uxK6o6nsPyY+Jip+DzEtyKqJAeE8F78T/GlmHu/4XcNa/kYQYJeJOPge++3wF4Q+oLC+jWvAjnrfjNouTf36EC7brqUdC15Npe2v2TovVchQPEhpKaSJf02SP2xcCI8K06wYx3JeFEnYT29jx/FLQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY1P110MB0102.NAMP110.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: eb94b6d1-751e-4857-6bbf-08d956ba626b
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2021 20:07:56.3489
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7a18110d-ef9b-4274-acef-e62ab0fe28ed
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1P110MB0181
X-PassedThroughOnPremises: Yes
X-OriginatorOrg: Collins.com
X-Proofpoint-GUID: VPjVzkMbU9VFCQacTA5o4RaRk6uWWKN3
X-Proofpoint-ORIG-GUID: VPjVzkMbU9VFCQacTA5o4RaRk6uWWKN3
X-Proofpoint-Spam-Details: rule=outbound_default_notspam policy=outbound_default score=0 mlxscore=0
 lowpriorityscore=0 clxscore=1011 suspectscore=0 impostorscore=0
 priorityscore=1501 mlxlogscore=999 spamscore=0 adultscore=0 bulkscore=0
 phishscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2107140000 definitions=main-2108030127
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hello,=0A=
=0A=
(I didn't want to spam the whole LKML, so=A0I've included the LSM list and =
top hits with get_maintainer.pl on the scripts and tools folders.)=0A=
=0A=
I'm organizing a project to take some prototype scripting and publicly publ=
ish/rewrite.=A0 The script I'd like to add to the kernel code base breaks d=
own a kernel build and identifies the active code (using enabled Kconfig an=
d obj file list).=A0 It then uses the kernel version and queries a public v=
ulnerability database(NIST NVD) to identify possible patches against known =
vulnerabilities.=A0 The script then attempts to patch the source code to de=
termine which vulnerabilities are still present in the codebase.=A0 The end=
 goal is to help the user understand the state of the active codebase, wher=
eas most tools stop at the kernel version, and then the activity is all man=
ual.  For an example of what the scripting impact could improve, a recent K=
ernel 4.14.x dump of vulnerabilities had hundreds that needed to be paired =
down.  Our estimate before tooling put the effort at about 10-15mins a CVE =
(determine active code, review code paths in suggested patches).  =0A=
=0A=
Is this something that fits within your understanding of the "scripts or to=
ols" included in the kernel codebase?  If so, do scripting-related patches =
primarily hit the LKML or via subsystem lists related to the topic (I.e., t=
hen staging branches via the subsystem for merge).=0A=
=0A=
Thank you for any suggestions of which mailing lists, subsystems, or mainta=
iners I should include on the topic. =0A=
=0A=
--=0A=
Matthew Weber | Associate Director Software Engineer | Commercial Avionics=
=A0 =A0(Focused in Open Source products and Cybersecurity)=0A=
COLLINS AEROSPACE=0A=
400 Collins Road NE, Cedar Rapids, Iowa 52498, USA=0A=
Tel:=A0+1 319 295 7349 |=A0FAX:=A0+1 319 263 6099=0A=
matthew.weber@collins.com=A0=
