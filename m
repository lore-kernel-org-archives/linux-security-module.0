Return-Path: <SRS0=Yj31=56=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1479C2BA19
	for <linux-security-module@archiver.kernel.org>; Tue, 14 Apr 2020 15:50:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 789ED206D5
	for <linux-security-module@archiver.kernel.org>; Tue, 14 Apr 2020 15:50:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VLc0RHyT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440941AbgDNPuB (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 14 Apr 2020 11:50:01 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:27529 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2440206AbgDNPt7 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 14 Apr 2020 11:49:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586879398;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=C5AiC1VtAoWJEY/odyXCn7YoS2/DSWi+dbTyYEt2cZQ=;
        b=VLc0RHyThyvpxgG0kBRn05uMXIqWo6cUMaf4HprIHFA7KOHJJoiSzELT/pXKMhRZb1CfkA
        JXvKPCRrMS1kPBHKsxWTcLAKj5g279ZjXo0bgax8J5YoY0Np2ptgOiNRVjj0kyKjL+t/id
        TKBEU/nMEcbSs6IT4J+il5AeKMyDl3c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-323-nx3W3qOFP32vjbdOe67__g-1; Tue, 14 Apr 2020 11:49:56 -0400
X-MC-Unique: nx3W3qOFP32vjbdOe67__g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A286D107ACC4;
        Tue, 14 Apr 2020 15:49:55 +0000 (UTC)
Received: from localhost (ovpn-114-148.ams2.redhat.com [10.36.114.148])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0C16311D2CF;
        Tue, 14 Apr 2020 15:49:50 +0000 (UTC)
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     linux-security-module@vger.kernel.org
Cc:     Serge Hallyn <serge@hallyn.com>, linux-kernel@vger.kernel.org,
        Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH] capabilities: add description for CAP_SETFCAP
Date:   Tue, 14 Apr 2020 16:49:45 +0100
Message-Id: <20200414154945.142372-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

RG9jdW1lbnQgdGhlIHB1cnBvc2Ugb2YgQ0FQX1NFVEZDQVAuICBGb3Igc29tZSByZWFzb24gdGhp
cyBjYXBhYmlsaXR5CmhhZCBubyBkZXNjcmlwdGlvbiB3aGlsZSB0aGUgb3RoZXJzIGRpZC4KClNp
Z25lZC1vZmYtYnk6IFN0ZWZhbiBIYWpub2N6aSA8c3RlZmFuaGFAcmVkaGF0LmNvbT4KLS0tCiBp
bmNsdWRlL3VhcGkvbGludXgvY2FwYWJpbGl0eS5oIHwgMiArKwogMSBmaWxlIGNoYW5nZWQsIDIg
aW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2luY2x1ZGUvdWFwaS9saW51eC9jYXBhYmlsaXR5
LmggYi9pbmNsdWRlL3VhcGkvbGludXgvY2FwYWJpbGl0eS5oCmluZGV4IDI3MmRjNjlmYTA4MC4u
NzI4OGYwYWQ0NGFmIDEwMDY0NAotLS0gYS9pbmNsdWRlL3VhcGkvbGludXgvY2FwYWJpbGl0eS5o
CisrKyBiL2luY2x1ZGUvdWFwaS9saW51eC9jYXBhYmlsaXR5LmgKQEAgLTMzMiw2ICszMzIsOCBA
QCBzdHJ1Y3QgdmZzX25zX2NhcF9kYXRhIHsKIAogI2RlZmluZSBDQVBfQVVESVRfQ09OVFJPTCAg
ICAzMAogCisvKiBTZXQgb3IgcmVtb3ZlIGNhcGFiaWxpdGllcyBvbiBmaWxlcyAqLworCiAjZGVm
aW5lIENBUF9TRVRGQ0FQCSAgICAgMzEKIAogLyogT3ZlcnJpZGUgTUFDIGFjY2Vzcy4KLS0gCjIu
MjUuMQoK

