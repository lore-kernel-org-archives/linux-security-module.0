Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="afuFnskw"
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5C6019A6
	for <linux-security-module@vger.kernel.org>; Tue, 28 Nov 2023 17:07:07 -0800 (PST)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-5cd59f77d2dso57842327b3.3
        for <linux-security-module@vger.kernel.org>; Tue, 28 Nov 2023 17:07:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1701220027; x=1701824827; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jkt95eq+DL2Z8DFZ7ILb1n1z4A0zFQ9JGPcyVYsIM9c=;
        b=afuFnskwp69aI8txreRa1N8uxEmhxPu1c7pFpC3afcsUaxwmE1xhJrGgHm+CKJKmqk
         P2GdjESxY4OfPXsS6YEeULJ7i7HAPtwSbucpJ7GxxkW8XMqvt4/MFijHRc3f62WZYTPy
         j4VykxThicXgVtszZ8OBT4v+0W5hgUmDMR5lHxJGha7ioTCNNSx9LOX+eLz7O3Kh6Cmq
         DC8IkNwU1mPcGnBXwE3bU0NncGSSiNMkiecjwxwSsAQrv6mhSaJeuSup4P+SgbHJLGcq
         ERfej/p43UDxrgl4viWG+nUmPpPv9Cd71fRB9JUad7UEnQUuCIh3eEKCWMI9GKokHHQc
         4QxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701220027; x=1701824827;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jkt95eq+DL2Z8DFZ7ILb1n1z4A0zFQ9JGPcyVYsIM9c=;
        b=qCT7rRZIG8ykzEVZ8ChT9VY8TTi2L/xmPeJYWgF1ww0GHiNHHBAuKUjLHa9Mm1Ps5n
         fh4shN4cMx2ITxMcyauQ/eSpnRb8BPNSna2EgfcFFAdMT7nVRtZw6zfzYzp4pWfBsSj1
         lsXCxIvWWO7ifGtzoqDdSyvPWmB/uX6e8d0R1lvh/Ap0rzWqhoTSWpfn1IMF0MOGf1aT
         yjOJqhgXVueTXufxE1NXbyci/X8T5l8G0Q9vSqkJlvgVRrbiP4q4HMlyhDnwufjcyo4f
         Uosuozd0HQeUtMV41GlAcQI9n7vqxxm9n8PNniq1irU/gWkCpTtZtH+rbmI8soPge5c+
         +lhQ==
X-Gm-Message-State: AOJu0YwkOp63rHRkZog8Uh/wAf7zgjPstoh/zwDxt/ySKY6flKKJKDxz
	UqNpK0JWzUaZCERwFN9KFEi+DMuwiujvxKtJJUzW
X-Google-Smtp-Source: AGHT+IHrFUwjcNVag5pJZmje3+cQULqNQmC5OGUeW1j6G1Cih5a/XEsyDtGSL2dYDowlJ5/Nt6bZHxk+vLu+BQ5qDoY=
X-Received: by 2002:a25:ab8b:0:b0:d9a:c4cf:a066 with SMTP id
 v11-20020a25ab8b000000b00d9ac4cfa066mr17983616ybi.34.1701220027096; Tue, 28
 Nov 2023 17:07:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6c0c32d5-e636-2a0e-5bdf-538c904ceea3@linux.microsoft.com>
 <8bff2bf1a4629aacec7b6311d77f233cb75b2f8a.camel@linux.ibm.com>
 <CAHC9VhRm9Tzz3C-VTdXS4s1_-kPQQ6RXMt8JGCS4jorJ0VURyQ@mail.gmail.com>
 <CAHC9VhSJ7MKNM7nMXR3xE-cNMrYB4AT+B76wzF1cKy2JM9tBrA@mail.gmail.com>
 <1b6853e8354af7033e6d87e77cfb175526753c38.camel@linux.ibm.com>
 <CAHC9VhSnDQ-d9dh_icqNyhpT+cTGQOqGh8+cbN3QzF_qPehvaA@mail.gmail.com>
 <28c4136d0fe360a7fcf6a6547120dc244be0edc3.camel@linux.ibm.com>
 <CAHC9VhTykrsXTuWfRe3rzg2SMbzynvgwXmxVpN5T0cfY7YrkwA@mail.gmail.com> <d5e2358a0a7aaf4455b1f479483b312e98aa07d5.camel@linux.ibm.com>
In-Reply-To: <d5e2358a0a7aaf4455b1f479483b312e98aa07d5.camel@linux.ibm.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 28 Nov 2023 20:06:56 -0500
Message-ID: <CAHC9VhRNLzbW++rW3Hep+3yyJZRRvZ4h7LuKcSbRRn-wqh-PAQ@mail.gmail.com>
Subject: Re: [RFC V2] IMA Log Snapshotting Design Proposal
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: Tushar Sugandhi <tusharsu@linux.microsoft.com>, linux-integrity@vger.kernel.org, 
	peterhuewe@gmx.de, Jarkko Sakkinen <jarkko@kernel.org>, jgg@ziepe.ca, 
	Ken Goldman <kgold@linux.ibm.com>, bhe@redhat.com, vgoyal@redhat.com, 
	Dave Young <dyoung@redhat.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, jmorris@namei.org, 
	serge@hallyn.com, James Bottomley <James.Bottomley@hansenpartnership.com>, 
	linux-security-module@vger.kernel.org, 
	Tyler Hicks <tyhicks@linux.microsoft.com>, 
	Lakshmi Ramasubramanian <nramas@linux.microsoft.com>, 
	Sush Shringarputale <sushring@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 28, 2023 at 7:09=E2=80=AFAM Mimi Zohar <zohar@linux.ibm.com> wr=
ote:
> On Mon, 2023-11-27 at 17:16 -0500, Paul Moore wrote:
> > On Mon, Nov 27, 2023 at 12:08=E2=80=AFPM Mimi Zohar <zohar@linux.ibm.co=
m> wrote:
> > > On Wed, 2023-11-22 at 09:22 -0500, Paul Moore wrote:

...

> > If we are going to have a record count, I imagine it would also be
> > helpful to maintain a securityfs file with the total size (in bytes)
> > of the in-memory measurement log.  In fact, I suspect this will
> > probably be more useful for those who wish to manage the size of the
> > measurement log.
>
> A running number of bytes needed for carrying the measurement list
> across kexec already exists.  This value would be affected when the
> measurement list is trimmed.

There we go, it should be trivial to export that information via securityfs=
.

> > > Defining other IMA securityfs files like
> > > how many times the measurement list has been trimmed might be
> > > beneficial as well.
> >
> > I have no objection to that.  Would a total record count, i.e. a value
> > that doesn't reset on a snapshot event, be more useful here?
>
> <securityfs>/ima/runtime_measurements_count already exports the total
> number of measurement records.

I guess the question is would you want 'runtime_measurements_count' to
reflect the current/trimmed log size or would you want it to reflect
the measurements since the initial cold boot?  Presumably we would
want to add another securityfs file to handle the case not covered by
'runtime_measurements_count'.

> > > Before defining a new critical-data record, we need to decide whether
> > > it is really necessary or if it is redundant.  If we define a new
> > > "critical-data" record, can it be defined such that it doesn't requir=
e
> > > pausing extending the measurement list?  For example, a new simple
> > > visual critical-data record could contain the number of records (e.g.
> > > <securityfs>/ima/runtime_measurements_count) up to that point.
> >
> > What if the snapshot_aggregate was a hash of the measurement log
> > starting with either the boot_aggregate or the latest
> > snapshot_aggregate and ending on the record before the new
> > snapshot_aggregate?  The performance impact at snapshot time should be
> > minimal as the hash can be incrementally updated as new records are
> > added to the measurement list.  While the hash wouldn't capture the
> > TPM state, it would allow some crude verification when reassembling
> > the log.  If one could bear the cost of a TPM signing operation, the
> > log digest could be signed by the TPM.
>
> Other critical data is calculated, before calling
> ima_measure_critical_data(), which adds the record to the measurement
> list and extends the TPM PCR.
>
> Signing the hash shouldn't be an issue if it behaves like other
> critical data.
>
> In addition to the hash, consider including other information in the
> new critical data record (e.g. total number of measurement records, the
> number of measurements included in the hash, the number of times the
> measurement list was trimmed, etc).

It would be nice if you could provide an explicit list of what you
would want hashed into a snapshot_aggregate record; the above is
close, but it is still a little hand-wavy.  I'm just trying to reduce
the back-n-forth :)

--=20
paul-moore.com
