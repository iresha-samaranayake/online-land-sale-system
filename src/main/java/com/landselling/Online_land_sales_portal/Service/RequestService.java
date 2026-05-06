package com.landselling.Online_land_sales_portal.Service;

import com.landselling.Online_land_sales_portal.Repository.RequestRepository;
import com.landselling.Online_land_sales_portal.entity.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;

@Service
public class RequestService {

    @Autowired
    private RequestRepository requestRepository;

    /**
     * Create a new request
     */
    @Transactional
    public Request createRequest(User requester, Land land, RequestType requestType, String message, 
                                  String contactPhone, String contactEmail, String preferredContactTime) {
        Request request = new Request();
        request.setRequester(requester);
        request.setLand(land);
        request.setRequestType(requestType);
        request.setMessage(message);
        request.setContactPhone(contactPhone);
        request.setContactEmail(contactEmail);
        request.setPreferredContactTime(preferredContactTime);
        request.setStatus(RequestStatus.PENDING);
        
        return requestRepository.save(request);
    }

    /**
     * Get all requests for a specific land
     */
    @Transactional(readOnly = true)
    public List<Request> getRequestsForLand(Land land) {
        return requestRepository.findByLand(land);
    }

    /**
     * Get all requests made by a user
     */
    @Transactional(readOnly = true)
    public List<Request> getRequestsByUser(User user) {
        return requestRepository.findByRequester(user);
    }

    /**
     * Get all requests for lands owned by a seller
     */
    @Transactional(readOnly = true)
    public List<Request> getRequestsForSeller(User seller) {
        return requestRepository.findByLandSeller(seller);
    }

    /**
     * Get all pending requests for a seller's lands
     */
    @Transactional(readOnly = true)
    public List<Request> getPendingRequestsForSeller(User seller) {
        return requestRepository.findPendingRequestsByLandSeller(seller);
    }

    /**
     * Get all requests (for admin)
     */
    @Transactional(readOnly = true)
    public List<Request> getAllRequests() {
        return requestRepository.findAllByOrderByCreatedAtDesc();
    }

    /**
     * Get request by ID
     */
    @Transactional(readOnly = true)
    public Request getRequestById(Long id) {
        return requestRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Request not found with id: " + id));
    }

    /**
     * Approve a request
     */
    @Transactional
    public Request approveRequest(Long requestId, User processedBy, String responseMessage) {
        Request request = getRequestById(requestId);
        request.setStatus(RequestStatus.APPROVED);
        request.setProcessedBy(processedBy);
        request.setProcessedAt(LocalDateTime.now());
        request.setResponseMessage(responseMessage);
        
        return requestRepository.save(request);
    }

    /**
     * Reject a request
     */
    @Transactional
    public Request rejectRequest(Long requestId, User processedBy, String responseMessage) {
        Request request = getRequestById(requestId);
        request.setStatus(RequestStatus.REJECTED);
        request.setProcessedBy(processedBy);
        request.setProcessedAt(LocalDateTime.now());
        request.setResponseMessage(responseMessage);
        
        return requestRepository.save(request);
    }

    /**
     * Delete a request (only by the requester and only if it's pending)
     */
    @Transactional
    public void deleteRequest(Long requestId, User requester) {
        Request request = getRequestById(requestId);
        
        // Only allow deletion by the requester
        if (!request.getRequester().getId().equals(requester.getId())) {
            throw new RuntimeException("You can only delete your own requests");
        }
        
        // Only allow deletion of pending requests
        if (request.getStatus() != RequestStatus.PENDING) {
            throw new RuntimeException("Only pending requests can be deleted");
        }
        
        requestRepository.deleteById(requestId);
    }
}

