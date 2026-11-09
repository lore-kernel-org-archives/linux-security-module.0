Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794247274;
	b=MXRZyLLXf6i517YuqL+RN3RYwrHMq2BBywovj2techWeOCjdPWRkLsF+Tl2WhGA4TwaF
	 4AsAh63Rr1f6B9/QXeXv7sSSp23E8TckrQUgP0lkF7gKb4A/4HtuBJWtUVaxLy4vnkqgP
	 6ZZa5yYAFL1b8SdmqOVqqvaKZmGaTXqhoC0nQJH6S4aQtpekaKtnOk8/Fr6I1vl8xO+UY
	 ocE6MRwU9tRH4VUkHSRVoPWxFbb+0jVn5jEP4CX7hupWj4scU0VUg75xGjyohUVXfRl/D
	 Andx0kZap0vU89K19mD1FyM/GG/7qDDuJLzhaqDwaUmRsNxk98wMM56jVhgU4a6vwyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794247274;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:In-Reply-To:X-Scanned-By:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Disposition;
	bh=uqQObdUpHHYtUe+LeCHrZ/2wo3MZK4ZISN3fNU+Q+88=;
	b=YOvFBaiMqWOP5b0YxQujUgIR6gPX6ICs3TklGzgssXPMhWhmUlX8qnvyX2qdtMOWvLM+
	 DQjId+5LdXYhgJY9hvvD2/SwyciACEJsMqD6R7oO12ldmSpUUF2AOEInHExOwIQLsNQz5
	 x/tZ7DExarRK+3CZjWkY7dOnyfvX26lrjNw/jAuQ7iYI+ukgEo7cqX188T9V3029jF9SE
	 eX4ylzi/JXJcOpRr3aSRq/ExfIpHIClHhNig72nA/6WjV+peIbo/VXasZrQZbR0f2YtIB
	 leWrP5yw5J1Z7jmmrTFlxW/fBE2eUn5kgHvs3efDhmxB1RjB6iBVtW/GjhjkDaiT5Xw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NVtZrvpj;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A81606A332
	for <linux-security-module@vger.kernel.org>; Mon,  9 Nov 2026 18:01:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 76A81606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NVtZrvpj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794247273;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uqQObdUpHHYtUe+LeCHrZ/2wo3MZK4ZISN3fNU+Q+88=;
	b=NVtZrvpjCoL5u3yK1KQIcQVu2UM4tChcy5f++P3HTGys/mmWt0rzZueerdMtn2N/2G8WG8
	5H/dFVv+lTUJbYv4vjk2gQTYSLuDwabT0eqBARptFaXTqjoEpPKp9BDLJHJXaM6NppCtxB
	dZXpxc28Dp7OgPM53ee3MC8HxGxtSTc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-43-Q-0kTqdZPtqltUwQp3l6_g-1; Mon,
 09 Nov 2026 13:01:09 -0500
X-MC-Unique: Q-0kTqdZPtqltUwQp3l6_g-1
X-Mimecast-MFC-AGG-ID: Q-0kTqdZPtqltUwQp3l6_g_1794247265
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 179B1180075A;
	Mon,  9 Nov 2026 18:01:03 +0000 (UTC)
Received: from onestero-thinkpadp1gen7.tpbc.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 71C211956087;
	Mon,  9 Nov 2026 18:00:52 +0000 (UTC)
Received: by onestero-thinkpadp1gen7.tpbc.csb (nbSMTP-1.00) for uid 13628
	oleg@redhat.com; Mon,  9 Nov 2026 19:01:02 +0100 (CET)
Date: Mon, 9 Nov 2026 19:00:51 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: "Serge E. Hallyn" <serge@hallyn.com>
Cc: kees@kernel.org, akpm@linux-foundation.org, david@kernel.org,
	Jinjie Ruan <ruanjinjie@huawei.com>, ljs@kernel.org,
	liam@infradead.org, vbabka@kernel.org, rppt@kernel.org,
	surenb@google.com, mhocko@suse.com, mingo@redhat.com,
	peterz@infradead.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, kprateek.nayak@amd.com, paul@paul-moore.com,
	jmorris@namei.org, shuah@kernel.org, brauner@kernel.org,
	alexjlzheng@tencent.com, jannh@google.com, jaime.saguillo@gmail.com,
	elver@google.com, blbllhy@gmail.com, bvanassche@acm.org,
	pjw@kernel.org, broonie@kernel.org, debug@rivosinc.com,
	tglx@kernel.org, aleksey.oladko@virtuozzo.com,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org, morgan@kernel.org
Subject: Re: [RFC PATCH v2 2/3] security: Add PR_CAPBSET_DROP_MASK for
 process-wide bounding-set drops
Message-ID: <avIKUzCKAkfC-wuk@redhat.com>
References: <20260929130200.1638343-1-ruanjinjie@huawei.com>
 <20260929130200.1638343-3-ruanjinjie@huawei.com>
 <atjN3JX7sWx9kpQ5@hallyn.com>
 <avHfm5/mVtuN/oPW@hallyn.com>
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <avHfm5/mVtuN/oPW@hallyn.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-MFC-PROC-ID: 3ZafUmvmCJj2jJa7fGRW6pvdghayTBWCcNWNh9DO1hI_1794247265
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On 11/09, Serge E. Hallyn wrote:
>
> Hi Oleg,
>
> please see below.  Do you have any issues with this use of sighand?

Hi Serge,

I already tried to look at this patch, but sorry, can't really comment.

I'll try to take another look, but can't promise much, I don't understand
the problem space (I could never reallly understand capabilites in details).

Oleg.

