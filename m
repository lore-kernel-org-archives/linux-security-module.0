From: jmorris@namei.org (James Morris)
Date: Wed, 14 Mar 2018 08:51:48 +1100 (AEDT)
Subject: [RFC PATCH 1/5] ima: extend clone() with IMA namespace support
In-Reply-To: <c39350db-046f-ea70-15e4-210884548b1e@linux.vnet.ibm.com>
References: <20170720225033.21298-1-mkayaalp@linux.vnet.ibm.com>
	<20170720225033.21298-2-mkayaalp@linux.vnet.ibm.com>
	<20170725175317.GA727@mail.hallyn.com>
	<1501008554.3689.30.camel@HansenPartnership.com>
	<20170725190406.GA1883@mail.hallyn.com>
	<1501009739.3689.33.camel@HansenPartnership.com>
	<1501012082.27413.17.camel@linux.vnet.ibm.com>
	<645db815-7773-e351-5db7-89f38cd88c3d@linux.vnet.ibm.com>
	<20170725204622.GA4969@mail.hallyn.com>
	<97839865-b0ab-8e5d-114e-0603ef2edf6f@linux.vnet.ibm.com>
	<20180309025942.GA15295@mail.hallyn.com>
	<ec137677-34f8-df91-0d1c-6c6d6c951496@linux.vnet.ibm.com>
	<alpine.LRH.2.21.1803120953310.26512@namei.org>
	<c39350db-046f-ea70-15e4-210884548b1e@linux.vnet.ibm.com>
Message-ID: <alpine.LRH.2.21.1803140851120.13609@namei.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, 13 Mar 2018, Stefan Berger wrote:

> On 03/11/2018 06:58 PM, James Morris wrote:
> > On Fri, 9 Mar 2018, Stefan Berger wrote:
> > 
> > > Yuqiong is publishing a paper in this area. I believe the conference is
> > > only
> > > later this year.
> > > 
> > > Our goals are to enable IMA measurements, appraisal, and auditing inside a
> > > container using namespaces.
> > This is excellent to have -- can you include this requirements analysis as
> > a file Documentation/security on the next posting?
> > 
> > Also, if you need a public space for managing these kinds of documents,
> > consider utilizing
> > http://kernsec.org/wiki/index.php/Linux_Kernel_Integrity
> 
> Thanks for the pointer. I tried creating an account, but the interface
> wouldn't let me. Who is managing it?

Email me for an account, per the note on the front page.


-- 
James Morris
<jmorris@namei.org>

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
