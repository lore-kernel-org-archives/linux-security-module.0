Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F17DC433C1
	for <linux-security-module@archiver.kernel.org>; Wed, 31 Mar 2021 02:45:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0763E619CD
	for <linux-security-module@archiver.kernel.org>; Wed, 31 Mar 2021 02:45:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233067AbhCaCok (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 30 Mar 2021 22:44:40 -0400
Received: from m13115.mail.163.com ([220.181.13.115]:39595 "EHLO
        m13115.mail.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233293AbhCaCoR (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 30 Mar 2021 22:44:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=4q21p
        Y4sfrLC2Lw/NNcHPh31O6eTbSW9Hf/qFvGG9nE=; b=gftGz8arij1EamDNUskqv
        L7l1OGIbBBD7RdFq5YvleoyiIYOgLTj2n9Cc32Q6EDNL42ydmZZc7nnyD+aHow2H
        3hiNg2pTnUDuhVMIRuHNrytK2FVHknQuYEssrQ5VeZqJo3ivZYubfes/ywlFX2dv
        Kf21TDxcLfQdLmAxY/UiOU=
Received: from yacanliu$163.com ( [183.136.182.140] ) by
 ajax-webmail-wmsvr115 (Coremail) ; Wed, 31 Mar 2021 10:44:05 +0800 (CST)
X-Originating-IP: [183.136.182.140]
Date:   Wed, 31 Mar 2021 10:44:05 +0800 (CST)
From:   =?UTF-8?B?5YiY5Lqa54G/?= <yacanliu@163.com>
To:     "Casey Schaufler" <casey@schaufler-ca.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        LKML <linux-kernel@vger.kernel.org>,
        "Linux Security Module list" <linux-security-module@vger.kernel.org>
Subject: Re:Commit f211ac154577ec9ccf07c15f18a6abf0d9bdb4ab breaks Smack TCP
 connections
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20210104(ab8c30b6)
 Copyright (c) 2002-2021 www.mailtech.cn 163com
In-Reply-To: <3f8328fe-e648-9d0e-729d-eb6787f11bf9@schaufler-ca.com>
References: <3f8328fe-e648-9d0e-729d-eb6787f11bf9.ref@schaufler-ca.com>
 <3f8328fe-e648-9d0e-729d-eb6787f11bf9@schaufler-ca.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <9b85945.3cfb.178862aa787.Coremail.yacanliu@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: c8GowADX7e314WNgDqyxAQ--.64061W
X-CM-SenderInfo: p1dft0xolxqiywtou0bp/xtbBdR5mS1aD+qYbBAABsR
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

SGkgQ2FzZXY6CgpBIHF1b3RlIGZyb20gdGhlIGxpc3RlbigyKSBtYW4gcGFnZSBvbiBteSBVYnVu
dHUgc3lzdGVtOgpUaGUgYmFja2xvZyBhcmd1bWVudCBkZWZpbmVzIHRoZSBtYXhpbXVtIGxlbmd0
aCB0byB3aGljaMKgCnRoZSBxdWV1ZSBvZiBwZW5kaW5nIGNvbm5lY3Rpb25zIGZvciBzb2NrZmQg
bWF5IGdyb3cuCkkgdGhpbmsgdGhpcyBpbXBsaWVzIHRoYXQgdGhlICdiYWNrbG9nJyBtdXN0IGJl
IGdyZWF0ZXIgdGhhbiB6ZXJvLgpJbiB0aGUgdGVzdCBzb3VyY2UgZmlsZSAodG9vbHMvc21hY2st
aXB2NC10Y3AtcGVlcnNlYy5jKSBMaW5lIDYwCkkgZm91bmQgdGhlIGZvbGxvd2luZyBjb2RlOgpp
ZiAobGlzdGVuKGZpcnN0c29jaywgMCkgPCAwKSB7CgnCoCDCoCBwcmludGYoIiVzLWxpc3Rlblxu
IiwgYXJndlswXSk7CgnCoCDCoCBleGl0KDEpOwp9ClRoYXQgbWVhbnMgdGhhdCBzb2NrIHdpbGwg
bm90IGFjY2VwdCBhbnkgcmVxdWVzdHMswqAKc28gY2xpZW50wqBUQ1AgY29ubmVjdGlvbnMgaGFu
ZyB3aXRoIFNZTl9TRU5ULgpJbiBvcGVuc3NoIGNhc2UswqBpdCB1c2UgU1NIX0xJU1RFTl9CQUNL
TE9HIGFzIDEyOC4KCkF0IDIwMjEtMDMtMzAgMjM6NDI6MDQsICJDYXNleSBTY2hhdWZsZXIiIDxj
YXNleUBzY2hhdWZsZXItY2EuY29tPiB3cm90ZToKPkNvbW1pdCBmMjExYWMxNTQ1NzdlYzljY2Yw
N2MxNWYxOGE2YWJmMGQ5YmRiNGFiICduZXQ6IGNvcnJlY3QKPnNrX2FjY2VwdHFfaXNfZnVsbCgp
JyBicmVha3MgYSBzeXN0ZW0gd2l0aCB0aGUgU21hY2sgTFNNLgo+UmV2ZXJ0aW5nIHRoaXMgY2hh
bmdlIHJlc3VsdHMgaW4gYSByZXR1cm4gdG8gY29ycmVjdCBiZWhhdmlvci4KPgo+VGhlIFNtYWNr
IHRlc3RzdWl0ZSBjYW4gYmUgZm91bmQgYXQ6Cj4JaHR0cHM6Ly9naXRodWIuY29tL3NtYWNrLXRl
YW0vc21hY2stdGVzdHN1aXRlLmdpdAo+Cj5UaGUgZmFpbGluZyB0ZXN0IGlzIGlwdjQtdGNwLWxv
Y2FsLXBlZXJzZWMuc2gsIGJ1dCBpdCBzZWVtcwo+dGhhdCBtb3N0IFRDUCBjb25uZWN0aW9ucyBo
YW5nIHdpdGggU1lOX1NFTlQuIE9kZGx5LCBzc2gKPnRvIDEyNy4wLjAuMSB3b3JrcywgYnV0IG90
aGVyIFRDUCBjb25uZWN0aW9ucyB0aW1lb3V0Lgo+Cj4KPgo+CgoKCsKgCgoKwqA=
