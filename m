From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Tue, 06 Jun 2017 06:56:31 -0400
Subject: [Linux-ima-devel] [PATCH 5/7] ima: add securityfs interface to
	save a measurements list with kexec header
In-Reply-To: <c4aa904b-052e-778d-caf9-47fbe8d961cb@huawei.com>
References: <20170516125347.10574-1-roberto.sassu@huawei.com>
	<20170516125347.10574-6-roberto.sassu@huawei.com>
	<1496642698.2998.104.camel@linux.vnet.ibm.com>
	<c4aa904b-052e-778d-caf9-47fbe8d961cb@huawei.com>
Message-ID: <1496746591.5546.28.camel@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, 2017-06-06 at 10:49 +0200, Roberto Sassu wrote:
> On 6/5/2017 8:04 AM, Mimi Zohar wrote:
> > On Tue, 2017-05-16 at 14:53 +0200, Roberto Sassu wrote:
> >> Through the new interface binary_kexec_runtime_measurements, it will be
> >> possible to read the same content returned by binary_runtime_measurements,
> >> with the kexec header prepended.
> >>
> >> The new interface has been added for testing ima_restore_measurement_list()
> >> which, at the moment, works only on PPC systems. The interface for reading
> >> the binary list with the kexec header will be provided in a separate patch.
> >>
> >> The patch reuses ima_measurements_start() and ima_measurements_next()
> >> to send the measurements list to userspace. Their behavior changes
> >> depending on the current dentry.
> >>
> >> To provide the correct information in the kexec header,
> >> ima_measurements_start() has to iterate over the whole list and calculate
> >> the number of entries and the total size. It is not possible to read
> >> the value of the global variable binary_runtime_size and ima_htable.len
> >> without taking ima_extend_list_mutex, because there might have been a list
> >> add between the two read operations.
> >
> > Please correct me if I'm wrong.  Your code walks the measurement list
> > calculating the total number of measurements and the memory size
> > needed to store in the kexec header.  Can't there be additional
> > measurements between the time these values - total number of
> > measurements and memory needed - were calculated and actually saving
> > the measurements?  How would that be any different than the problem
> > you're trying to solve?  In both cases, the number of measurements
> > might be less than the actual number of measurements.
> >
> > As long as you query the number of measurements before getting the
> > memory needed, unless you're trying to verify a TPM quote, having
> > fewer measurements shouldn't be a problem for testing.
> 
> The problem is that the total number of entries and the required
> memory size might be inconsistent without taking ima_extend_list_mutex.
> ima_measurements_start() could read the entries counter before
> it is incremented by ima_add_digest_entry() and the required memory
> size after it is updated. If this happens, the parser returns an error
> because ENFORCE_BUFEND is set for the last entry and there would be
> still data to read (the new entry added to the list).

I don't see this as being any different than what happens when the
kernel saves the measurement list. Originally, the memory size was
defined at kexec load, but only populated at kexec execute. ?There was
plenty of time between the kexec load and execute for additional
measurement records to be added.

The upstreamed version defines the buffer size and populates it at
kexec load. ?However kexec load itself generates additional
measurements, so it has to reserve more memory than what is returned
by ima_get_binary_runtime_size(). (Refer to ima_add_kexec_buffer.)

When restoring the buffer, it processes the number of records as
stored in the header, making sure it doesn't go beyond the buffer
size.

Mimi

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
