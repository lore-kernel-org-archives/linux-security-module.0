From: tadeusz.struk@intel.com (Tadeusz Struk)
Date: Wed, 13 Jun 2018 11:05:26 -0700
Subject: [PATCH v3 2/2] tpm: add support for nonblocking operation
In-Reply-To: <f2ed324e-8512-5ac1-7e5b-29943bbace53@gmail.com>
References: <152882630662.30206.8805136953394285180.stgit@tstruk-mobl1.jf.intel.com>
	<152882631679.30206.9516257862583104447.stgit@tstruk-mobl1.jf.intel.com>
	<f2ed324e-8512-5ac1-7e5b-29943bbace53@gmail.com>
Message-ID: <c6ea057d-5818-7c3b-09c6-329856736941@intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 06/13/2018 10:55 AM, J Freyensee wrote:
>> +??? /*
>> +???? * If in nonblocking mode schedule an async job to send
>> +???? * the command return the size.
>> +???? * In case of error the err code will be returned in
>> +???? * the subsequent read call.
>> +???? */
>> +??? if (file->f_flags & O_NONBLOCK) {
>> +??????? queue_work(tpm_dev_wq, &priv->async_work);
>> +??????? return size;
> 
> Apologies for the question, but should there be a mutex_unlock() here?? It's about the only return statement I am seeing where I cannot tell if a mutex_unlock() will be called before return or is needed before return.? The rest of the code is pretty obvious the return statements are being re-factored to an out: block where the mutex_unlock() will always be called before returning.

Hi Jay,
We need to hold the lock until the whole command is sent and the device is ready for next one.
In case of the async job the mutex in unlocked in tpm_async_work() just after the tpm_transmit() returns.
Thanks for reviewing.
-- 
Tadeusz
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
