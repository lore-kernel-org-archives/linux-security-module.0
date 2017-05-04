From: stefanb@linux.vnet.ibm.com (Stefan Berger)
Date: Thu, 4 May 2017 16:03:18 -0400
Subject: [PATCH v2 3/3] tpm: vtpm_proxy: Add ioctl to request locality
	prepended to command
In-Reply-To: <20170504184007.46efvqyqwxjkzwuq@intel.com>
References: <1493384538-27883-1-git-send-email-stefanb@linux.vnet.ibm.com>
	<1493384538-27883-4-git-send-email-stefanb@linux.vnet.ibm.com>
	<20170503223747.zefh76m4youqlgje@intel.com>
	<40cd7d48-f6d1-39f4-99a3-916c7cdbb636@linux.vnet.ibm.com>
	<20170504091738.rxl77hjzf6vnpuda@intel.com>
	<e8408f9b-d53d-5af0-3678-e851d78ba99e@linux.vnet.ibm.com>
	<20170504184007.46efvqyqwxjkzwuq@intel.com>
Message-ID: <daa25807-53cd-1abd-d2fa-57e01e37da9f@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 05/04/2017 02:40 PM, Jarkko Sakkinen wrote:
> On Thu, May 04, 2017 at 07:14:27AM -0400, Stefan Berger wrote:
>> On 05/04/2017 05:17 AM, Jarkko Sakkinen wrote:
>>> On Wed, May 03, 2017 at 07:40:48PM -0400, Stefan Berger wrote:
>>>> On 05/03/2017 06:37 PM, Jarkko Sakkinen wrote:
>>>>> On Fri, Apr 28, 2017 at 09:02:18AM -0400, Stefan Berger wrote:
>>>>>> Add an ioctl to request that the locality be prepended to every TPM
>>>>>> command.
>>>>> Don't really understand this change. Why locality is prenpended?
>>>> Commands can be executed under locality 0-3 and for some commands it is
>>>> important to know which locality a user may have chosen. How else should we
>>>> convey that locality to the TPM emulator ?
>>> Why this is not in the commit message?
>>>
>>> More scalable way to do this would be to have a set of vtpm proxy
>>> commands. There could be a command for requesting and releasing
>>> locality. That would be more clean.
>> I would think that if someone wanted to use locality it's the client using
>> /dev/tpm(rm)0 calling an ioctl or so and the vtpm proxy then merely passing
>> that locality to the backend (TPM emulator). I suppose the intention is to
>> support something like that following the addition of the new functions
>> request_locality and release_locality?
> What if we later on want to pass something else than locality to the
> backend? How that will work out?

'push' more data in front. 'pop' off by recipient. We could wrap the 
command in some form.

     Stefan

>
> /Jarkko
> --
> To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
